install-lab0:
	helm upgrade --install counter \
		./counter \
		--values lab0.values.yaml

install-openshift:
	helm upgrade --install counter \
		./counter \
		--values openshift.values.yaml

install-openshift:
	make install-openshift-dev
	make install-openshift-prod

install-openshift-dev:
	helm upgrade --install counter-dev \
		./counter \
		--values openshift-common.values.yaml \
		--values openshift-dev.values.yaml

install-openshift-prod:
	helm upgrade --install counter-prod \
		./counter \
		--values openshift-common.values.yaml \
		--values openshift-prod.values.yaml