.DEFAULT_GOAL := lint

lint:
	@shellcheck bashrc bin/* lib/* rc.d/*
.PHONY: lint
