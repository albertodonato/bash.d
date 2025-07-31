.DEFAULT_GOAL := lint

FILES = bashrc _shrc bin/* lib/* rc.d/*

lint:
	@shellcheck -s bash $(FILES)
.PHONY: lint
