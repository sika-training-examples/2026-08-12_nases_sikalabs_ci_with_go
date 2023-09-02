helm upgrade --install \
	ingress-nginx ingress-nginx \
	--repo https://kubernetes.github.io/ingress-nginx \
	--create-namespace \
	--namespace ingress-nginx \
	--set controller.service.type=LoadBalancer \
	--set controller.ingressClassResource.default=true \
	--set controller.kind=DaemonSet \
	--set controller.hostPort.enabled=true \
	--set controller.metrics.enabled=true \
	--set controller.config.use-proxy-protocol=false \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz \
	--wait
