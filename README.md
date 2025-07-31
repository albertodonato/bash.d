# Shell configuration files and scripts

[![Lint](https://github.com/albertodonato/shell.d/workflows/Lint/badge.svg)](https://github.com/albertodonato/shell.d/actions?query=workflow%3ALint)

The entry point are the `bashrc` and `zshrc` files in the base directory, which
can be just sourced from (or copied as) the main config file.

The repository consists of the following directories:

- `bin`: contains standalone scripts.

- `lib`: contains files with helper functions. These are automatically made
  available in the shell.

- `rc.d`: actual shell configuration (environment variables, aliases, ...).
  Files in this directory are automatically sourced at shell startup in
  alphabetic order.
  
  
Files in both `lib` and `rc.d` are looked up by `.sh` and `.<shell>` extensions
based on the current shell (`.bash` and `.zsh`).
