FILES = bashrc $(shell find bin lib rc.d -type f)

lint: SHELLCHECK = shellcheck
lint: SCRIPTS = $(FILES)
lint: _lint-command

lint-docker: SHELLCHECK = docker run --rm -it -v $(PWD):/repo koalaman/shellcheck
lint-docker: SCRIPTS = $(patsubst %,/repo/%,$(FILES))
lint-docker: _lint-command

_lint-command:
	@$(SHELLCHECK) -s bash $(SCRIPTS)

.PHONY: lint lint-docker _lint-command
