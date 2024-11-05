terraform-providers-lock:
	rm -rf .terraform.lock.hcl
	terraform providers lock \
		-platform=darwin_amd64 \
		-platform=darwin_arm64 \
		-platform=linux_amd64
	git add .terraform.lock.hcl
	git commit -m "[auto] chore(terraform/users): Update Terraform lock .terraform.lock.hcl" .terraform.lock.hcl
