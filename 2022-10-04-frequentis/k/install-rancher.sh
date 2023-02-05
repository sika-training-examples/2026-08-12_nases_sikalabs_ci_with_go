helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.k8s.sikademo.com \
  --set ingress.tls.source=letsEncrypt \
  --set bootstrapPassword=admin
