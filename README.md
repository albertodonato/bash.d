# Bash configuration

[![Lint](https://github.com/albertodonato/bash.d/workflows/Lint/badge.svg)](https://github.com/albertodonato/bash.d/actions?query=workflow%3ALint)

Entry point is the `bashrc` file in the base directory can be just sourced from
(or copied as) the main config file.

The repository consists of the following directories:

- `lib`: contains files with helper functions. These are automatically made
  available in the shell.

- `rc.d`: actual shell configuration (environment variables, aliases, ...).
  Files in this directory are automatically sourced at shell startup in
  alphabetic order.
