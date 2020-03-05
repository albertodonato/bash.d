# Ack's bash setup

[![Build Status](https://travis-ci.com/albertodonato/bash.d.svg?branch=master)](https://travis-ci.com/albertodonato/bash.d)

My own Bash shell configuration.

The entry point is the `bashrc` file in the top directory, which can be just
sourced from (or copied as) `~/.bashrc`.

The repository consists of the following directories:

- `bin`: contains standalone scripts.

- `lib`: contains files with helper functions. These are automatically made
  available in the shell, and can be also sourced in other scripts. The path of
  the directory is available as `$SYSTEM_SH_LIB_DIR`.

- `rc.d`: actual bash configuration (environment variables, aliases, ...),
  these are basically what goes in `.bashrc`, split in different files.  Files
  in this directory are automatically sourced at shell startup in alphabetic
  order.
