.DEFAULT_GOAL := lint

lint:
	@shellcheck -s bash bashrc bin/* lib/* rc.d/*
.PHONY: lint
