================
Ack's bash setup
================

My own Bash shell configuration.

The entry point is the ``bashrc`` file in the top directory, which can be just
sourced from ``~/.bashrc``.

There are 3 subdirectories:

- ``bin``, which contains standalone scripts

- ``lib``, contains files with helper functions. These are automatically made
  available in the shell, and can be also sourced in other scripts.

- ``rc.d``, actual bash configuration (environment variables, aliases, ...),
  these are basically what goes in ``.bashrc``, split in different files. Files
  in this directory are automaticall sourced at shell startup in alphabetic
  order.
