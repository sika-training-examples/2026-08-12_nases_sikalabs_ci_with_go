docker-build-and-push:
	make -C docker/debezium build-and-push
	make -C docker/postgres-writer build-and-push
	make -C docker/mongo-writer build-and-push
	make -C docker/consumer build-and-push

deploy:
	kubectl apply -f k8s/
