openshift:
	helm upgrade --install hello \
		--repo https://helm.sikalabs.io hello-world \
		--values openshift-common.values.yaml \
		--values openshift-hello.values.yaml ${EXTRA_ARGS}
	helm upgrade --install ahoj \
		--repo https://helm.sikalabs.io hello-world \
		--values openshift-common.values.yaml \
		--values openshift-ahoj.values.yaml ${EXTRA_ARGS}

lab0:
	helm upgrade --install hello \
		--repo https://helm.sikalabs.io hello-world \
		--values lab0-common.values.yaml \
		--values lab0-hello.values.yaml ${EXTRA_ARGS}
	helm upgrade --install ahoj \
		--repo https://helm.sikalabs.io hello-world \
		--values lab0-common.values.yaml \
		--values lab0-ahoj.values.yaml ${EXTRA_ARGS}