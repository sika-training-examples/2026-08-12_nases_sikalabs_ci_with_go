install-cluster-essentials:
	slu scripts kubernetes install-all \
		--base-domain k8s.sikademo.com

install-strimzi:
	kubectl create namespace kafka
	kubectl apply -f https://strimzi.io/install/latest?namespace=kafka -n kafka

install-kafka-cluster:
	kubectl apply -f k8s/kafka.yml

install-kafka-producer:
	kubectl apply -f k8s/producer.yml

install-kafka-consumer:
	kubectl apply -f k8s/consumer.yml

install-keda:
	helm install \
		keda \
		--repo https://kedacore.github.io/charts \
		keda \
		--namespace keda \
		--create-namespace

install-keda-scaledobject:
	kubectl apply -f k8s/scaledobject.yml

SCALE_PRODUCER_REPLICAS = 10

scale-producer:
	kubectl scale deployment producer --replicas=${SCALE_PRODUCER_REPLICAS}

cleanup:
	kubectl delete -f ./k8s
