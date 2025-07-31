# Ack's bash setup

[![Lint](https://github.com/albertodonato/bash.d/workflows/Lint/badge.svg)](https://github.com/albertodonato/bash.d/actions?query=workflow%3ALint)

My own Bash shell configuration.

The entry point is the `bashrc` file in the top directory, which can be just
sourced from (or copied as) `~/.bashrc`.

The repository consists of the following directories:

- `bin`: contains standalone scripts.

- `lib`: contains files with helper functions. These are automatically made
  available in the shell.

- `rc.d`: actual bash configuration (environment variables, aliases, ...),
  these are basically what goes in `.bashrc`, split in different files.  Files
  in this directory are automatically sourced at shell startup in alphabetic
  order.

## Setup

To install:

```bash
mkdir -p ~/system
git clone https://github.com/albertodonato/bash.d ~/system/bash.d
mv ~/.bashrc ~/.bashrc.orig
ln -sf system/bash.d/bashrc ~/.bashrc
```
