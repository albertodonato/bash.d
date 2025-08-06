.DEFAULT_GOAL := lint

BASH_FILES = bashrc lib/*.sh rc.d/*.sh

lint:
	@shellcheck -s bash $(BASH_FILES)
.PHONY: lint
