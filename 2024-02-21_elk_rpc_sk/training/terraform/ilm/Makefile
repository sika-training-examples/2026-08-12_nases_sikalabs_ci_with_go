terraform-providers-lock:
	rm -rf .terraform.lock.hcl
	terraform providers lock \
		-platform=darwin_amd64 \
		-platform=darwin_arm64 \
		-platform=linux_amd64
	git add .terraform.lock.hcl

terraform-providers-lock-commit:
	@make terraform-providers-lock
	git commit -m "[auto] chore(terraform/users): Update Terraform lock .terraform.lock.hcl" .terraform.lock.hcl

filebeat-foo:
	slu loggen --log-prefix ilm-foo | \
		filebeat -e -c $(shell pwd)/filebeat-foo.yml \
			--path.data $(shell pwd)/.tmp/filebeat-foo \
			--path.home $(shell pwd)/.tmp/filebeat-foo \
			--path.logs $(shell pwd)/.tmp/filebeat-foo

filebeat-bar:
	slu loggen --log-prefix ilm-bar | \
		filebeat -e -c $(shell pwd)/filebeat-bar.yml \
			--path.data $(shell pwd)/.tmp/filebeat-bar \
			--path.home $(shell pwd)/.tmp/filebeat-bar \
			--path.logs $(shell pwd)/.tmp/filebeat-bar
