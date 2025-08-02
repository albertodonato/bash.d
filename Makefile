.DEFAULT_GOAL := lint

BASH_FILES = bashrc _shrc
BASH_FILES += $(wildcard bin/*)
BASH_FILES += $(wildcard lib/*.sh) $(wildcard lib/*.bash)
BASH_FILES += $(wildcard rc.d/*.sh) $(wildcard rc.d/*.bash)

lint:
	@shellcheck -s bash $(BASH_FILES)
.PHONY: lint
