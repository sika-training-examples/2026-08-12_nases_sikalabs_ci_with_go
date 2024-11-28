install:
	helm upgrade --install \
	loki \
	loki \
	--version 5.48.0 \
	--repo https://grafana.github.io/helm-charts \
  --namespace loki \
  --create-namespace \
  --values loki.values.yml

uninstall:
	helm uninstall loki -n loki
