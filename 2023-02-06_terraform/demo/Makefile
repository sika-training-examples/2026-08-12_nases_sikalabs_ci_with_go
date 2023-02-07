fmt:
	terraform fmt -recursive

fmt-check:
	terraform fmt -recursive -check

lint-check:
	tflint --recursive

setup-git-hooks:
	rm -rf .git/hooks
	(cd .git && ln -s ../.git-hooks hooks)

generate-docs:
	terraform-docs md ./workspaces/commons > ./workspaces/commons/README.md
	terraform-docs md ./workspaces/dev > ./workspaces/dev/README.md
	terraform-docs md ./workspaces/prod > ./workspaces/prod/README.md

	terraform-docs md ./applications/example > ./applications/example/README.md

	terraform-docs md ./modules/vm > ./modules/vm/README.md

