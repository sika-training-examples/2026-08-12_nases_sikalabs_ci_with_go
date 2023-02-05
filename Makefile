remove-git-dirs:
	find . -not \( -path "./.git" \) -name ".git" \
		-exec rm -rf {} \;
