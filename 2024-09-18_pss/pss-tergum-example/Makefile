backup:
	tergum backup --config tergum.yml

run-minio:
	docker run --name minio -d -p 9000:9000 -p 9001:9001 \
		-e "MINIO_ROOT_USER=admin" \
		-e "MINIO_ROOT_PASSWORD=asdfasdf" \
		minio/minio server /data --console-address ":9001"
