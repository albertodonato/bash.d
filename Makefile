.DEFAULT_GOAL := lint

BASH_FILES = bashrc _shrc bin/* lib/*.{sh,bash} rc.d/*.{sh,bash}

lint:
	@shopt -s nullglob; shellcheck -s bash $(BASH_FILES)
.PHONY: lint
