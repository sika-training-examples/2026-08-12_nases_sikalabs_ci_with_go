helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.k8s2.sikademo.com \
  --set bootstrapPassword=admin \
  --set ingress.tls.source=letsEncrypt \
  --set letsEncrypt.email=le@sikademo.com \
  --set letsEncrypt.ingress.class=nginx
  