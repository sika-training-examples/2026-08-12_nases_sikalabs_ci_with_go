terraform-fmt:
	terraform fmt -recursive

terraform-fmt-check:
	terraform fmt -recursive -check

setup-git-hooks:
	rm -rf .git/hooks
	(cd .git && ln -s ../.git-hooks hooks)

_infracost:
ifndef ENV
	$(error ENV is undefined)
endif
	cd env/${ENV} && infracost breakdown --path . --show-skipped

_terraform-providers-lock:
ifndef ENV
	$(error ENV is undefined)
endif
	cd env/${ENV} && terraform providers lock \
		-platform=darwin_arm64 \
		-platform=darwin_amd64 \
		-platform=linux_arm64 \
		-platform=linux_amd64
	cd env/${ENV} && git add .terraform.lock.hcl
	cd env/${ENV} && git commit -m "deps(env/${ENV}): Update .terraform.lock.hcl" .terraform.lock.hcl

_terraform-init-state:
ifndef ENV
	$(error ENV is undefined)
endif
ifndef GITLAB_DOMAIN
	$(error GITLAB_DOMAIN is undefined)
endif
ifndef GITLAB_PROJECT_ID
	$(error GITLAB_PROJECT_ID is undefined)
endif
ifndef GITLAB_USERNAME
	$(error GITLAB_USERNAME is undefined)
endif
ifndef GITLAB_TOKEN
	$(error GITLAB_TOKEN is undefined)
endif
	cd env/${ENV} && terraform init \
		-backend-config="address=https://${GITLAB_DOMAIN}/api/v4/projects/${GITLAB_PROJECT_ID}/terraform/state/${ENV}" \
		-backend-config="lock_address=https://${GITLAB_DOMAIN}/api/v4/projects/${GITLAB_PROJECT_ID}/terraform/state/${ENV}/lock" \
		-backend-config="unlock_address=https://${GITLAB_DOMAIN}/api/v4/projects/${GITLAB_PROJECT_ID}/terraform/state/${ENV}/lock" \
		-backend-config="username=${GITLAB_USERNAME}" \
		-backend-config="password=${GITLAB_TOKEN}" \
		-backend-config="lock_method=POST" \
		-backend-config="unlock_method=DELETE" \
		-backend-config="retry_wait_min=5"
