SHELL := /bin/bash
.SHELLFLAGS := -s nullglob -c

.DEFAULT_GOAL := lint

BASH_FILES = bashrc _shrc bin/* lib/*.{sh,bash} rc.d/*.{sh,bash}

lint:
	@shellcheck -s bash $(BASH_FILES)
.PHONY: lint
