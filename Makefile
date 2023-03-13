.DEFAULT_GOAL := lint

FILES = bashrc bin/* lib/* rc.d/*

lint:
	@shellcheck -s bash $(FILES)
.PHONY: lint
