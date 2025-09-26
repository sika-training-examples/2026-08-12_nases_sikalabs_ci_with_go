package sk.pss.labapp;

import com.bettercloud.vault.Vault;
import com.bettercloud.vault.VaultConfig;
import com.bettercloud.vault.VaultException;
import com.bettercloud.vault.response.AuthResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

@SpringBootApplication
@RestController
public class labapp {

    private static final String VAULT_ADDR = "http://vault.vault:8200";
    private static final String ROLE_ID_FILE = "/run/secrets/role_id";
    private static final String SECRET_ID_FILE = "/run/secrets/secret_id";

    @Value("${vault.role-id:}")
    private String localRoleId;

    @Value("${vault.secret-id:}")
    private String localSecretId;

    private final Environment environment;

    public labapp(Environment environment) {
        this.environment = environment;
    }

    public static void main(String[] args) {
        SpringApplication.run(labapp.class, args);
    }

    @GetMapping("/")
    public String home() {
        String hostname = getHostname();
        String ipAddress = getIpAddress();
        String currentTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        String username = "Není k dispozici";
        String password = "Není k dispozici";

        try {
            Vault vault = initializeVault();
            username = vault.logical().read("secret/apps/labapp").getData().get("username");
            password = vault.logical().read("secret/apps/labapp").getData().get("password");
        } catch (VaultException | IOException e) {
            e.printStackTrace();
        }

        return String.format(
                "<h1>Vitaj v Docker Demo aplikácii!</h1>" +
                        "Hostname: %s<br>" +
                        "IP Adresa: %s<br>" +
                        "Aktuálny čas: %s<br>" +
                        "username: %s<br>" +
                        "password: %s<hr>(c) 2025 PSS a.s.",
                hostname, ipAddress, currentTime, username, password
        );
    }

    private Vault initializeVault() throws VaultException, IOException {
        VaultConfig config = new VaultConfig()
                .address("http://vault.vault:8200")
                // .sslConfig(new SslConfig().verify(true).build()) // enable & add CA in prod
                .build();

        Vault vault = new Vault(config, 2);

        // 1) Read the pod's ServiceAccount token
        String jwt = Files.readString(Paths.get("/var/run/secrets/kubernetes.io/serviceaccount/token"), StandardCharsets.UTF_8).trim();

        // 2) Login using the Kubernetes auth method
        AuthResponse auth = vault.auth().loginByKubernetes("labapp", jwt);

        // 3) Set the client token and return a Vault instance that uses it
        config.token(auth.getAuthClientToken());
        return new Vault(config);
    }

    private String getHostname() {
        try {
            return InetAddress.getLocalHost().getHostName();
        } catch (UnknownHostException e) {
            return "Neznámy hostname";
        }
    }

    private String getIpAddress() {
        try {
            return InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            return "Neznáma IP adresa";
        }
    }
}