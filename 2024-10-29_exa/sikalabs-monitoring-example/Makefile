install:
	helm upgrade --install \
		kube-prometheus-stack \
		--repo https://prometheus-community.github.io/helm-charts \
		kube-prometheus-stack \
		--version 65.1.1 \
		--namespace monitoring \
		--create-namespace \
		--values kube_prometheus_stack.values.yml \
		--wait

install_adapter:
	helm upgrade --install \
		prometheus-adapter\
		--repo https://prometheus-community.github.io/helm-charts \
		prometheus-adapter \
		--namespace monitoring \
		--create-namespace \
		--values prometheus_adapter.values.yml \
		--wait
