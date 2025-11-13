# docker-kubernetes-dhl

## Docker Installation

```
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Install Crane

```
apt-get install jq -y
VERSION=$(curl -s "https://api.github.com/repos/google/go-containerregistry/releases/latest" | jq -r '.tag_name')
OS=Linux       # or Darwin, Windows
ARCH=x86_64    # or arm64, x86_64, armv6, i386, s390x
curl -sL "https://github.com/google/go-containerregistry/releases/download/${VERSION}/go-containerregistry_${OS}_${ARCH}.tar.gz" > go-containerregistry.tar.gz
tar -zxvf go-containerregistry.tar.gz -C /usr/local/bin/ crane
```

## Manual multi service example (no docker compose)

Run

```
docker build -t counter .
docker network create mynet
docker run -d --name redis --network mynet redis
docker run --name counter -d -p 80:80 -e REDIS=redis --net mynet counter
```

Stop and cleanup

```
docker stop counter redis
docker rm counter redis
docker network rm mynet
```

## Run this example with docker compose

```
git clone https://github.com/sika-training-examples/2025-11-10_docker-kubernetes-dhl dhl
cd dhl
docker compose up -d
```

To stop and cleanup

```
docker compose down
```

## Install Kubernetes Tooling

### kubectl

```
curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /tmp/kubectl && chmod +x /tmp/kubectl && sudo mv /tmp/kubectl /usr/local/bin/kubectl
```

### helm

```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```

### k9s

```
curl -L https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz -o /tmp/k9s.tar.gz && tar -xzf /tmp/k9s.tar.gz -C /tmp && chmod +x /tmp/k9s && sudo mv /tmp/k9s /usr/local/bin/k9s
```

### k3d

```
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

### kubectx + kubens

```
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
```

### Aliases

```
echo "alias k=kubectl" >> ~/.zshrc
echo "alias kn=kubens" >> ~/.zshrc
echo "alias kx=kubectx" >> ~/.zshrc

echo "source <(kubectl completion zsh)" >> ~/.zshrc
echo "source <(helm completion zsh)" >> ~/.zshrc

source ~/.zshrc
```

## Run Training Cluster

```
docker ps -a -q | xargs -r docker rm -f
```

```
k3d cluster create default \
  --k3s-arg --disable=traefik@server:0 \
  --servers 1 \
  --port 80:80@loadbalancer \
  --port 443:443@loadbalancer \
  --wait
```

```
kubectl create ns training
```

```
kubectl config set-context --current --namespace training
```

## Clone kubernetes-training repo

```
git clone https://github.com/ondrejsika/kubernetes-training.git kubernetes
cd kubernetes
```

## Run hello_dhl example

```
kubectl apply -f hello_dhl
```

## List Deployments, Pods, Services

```
kubectl get deploy,po,service
```

watch

```
watch -n 0.2 kubectl get deploy,po,service
```

## Run Development image (sikalabs/dev) in the cluster

```
kubectl run -ti --rm --image ghcr.io/sikalabs/dev dev
```

## Install ingress-nginx controller

```
helm upgrade --install \
  ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --create-namespace \
  --namespace ingress-nginx \
  --set controller.service.type=ClusterIP \
  --set controller.ingressClassResource.default=true \
  --set controller.kind=DaemonSet \
  --set controller.hostPort.enabled=true \
  --set controller.metrics.enabled=true \
  --wait
```

## Install cert-manager

```
helm upgrade --install \
	cert-manager cert-manager \
	--repo https://charts.jetstack.io \
	--create-namespace \
	--namespace cert-manager \
	--set crds.enabled=true \
	--wait
```