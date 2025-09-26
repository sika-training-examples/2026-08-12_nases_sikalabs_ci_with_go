package main

import (
	"context"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"time"

	vault "github.com/hashicorp/vault/api"
)

func getenv(k, def string) string {
	if v := os.Getenv(k); v != "" {
		return v
	}
	return def
}

func mustSet(k, v string) {
	if err := os.Setenv(k, v); err != nil {
		log.Fatalf("setenv %s: %v", k, err)
	}
}

func loginWithKubernetes(ctx context.Context, client *vault.Client, mountPath, role, jwtPath string) (string, error) {
	jwtBytes, err := ioutil.ReadFile(jwtPath)
	if err != nil {
		return "", fmt.Errorf("read SA JWT: %w", err)
	}
	data := map[string]interface{}{
		"role": role,
		"jwt":  string(jwtBytes),
	}
	secret, err := client.Logical().WriteWithContext(ctx, fmt.Sprintf("auth/%s/login", mountPath), data)
	if err != nil {
		return "", fmt.Errorf("k8s login: %w", err)
	}
	if secret == nil || secret.Auth == nil || secret.Auth.ClientToken == "" {
		return "", fmt.Errorf("k8s login returned empty token")
	}
	return secret.Auth.ClientToken, nil
}

func getMongoDBURIFromVaultOrDie(vaultAddr, vaultRole, vaultKvMount, vaultKvPath, key string) string {
	vaultMount := getenv("VAULT_AUTH_MOUNT", "kubernetes")
	jwtPath := getenv("K8S_JWT_PATH", "/var/run/secrets/kubernetes.io/serviceaccount/token")

	cfg := vault.DefaultConfig()
	cfg.Address = vaultAddr

	client, err := vault.NewClient(cfg)
	if err != nil {
		log.Fatalf("vault client: %v", err)
	}

	ctx, cancel := context.WithTimeout(context.Background(), 8*time.Second)
	defer cancel()

	// ---- Login via Kubernetes auth ----
	token, err := loginWithKubernetes(ctx, client, vaultMount, vaultRole, jwtPath)
	if err != nil {
		log.Fatalf("vault k8s auth: %v", err)
	}
	client.SetToken(token)

	// ---- Read KV v2 secret ----
	kvMount := vaultKvMount
	kvPath := vaultKvPath

	kv := client.KVv2(kvMount)
	sec, err := kv.Get(ctx, kvPath)
	if err != nil {
		log.Fatalf("vault get %s/%s: %v", kvMount, kvPath, err)
	}
	raw, ok := sec.Data[key]
	if !ok {
		log.Fatalf("key %q not found in %s/%s", key, kvMount, kvPath)
	}
	url, ok := raw.(string)
	if !ok || url == "" {
		log.Fatalf("key %q is not a non-empty string", key)
	}
	return url
}
