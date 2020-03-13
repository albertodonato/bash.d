# -*- mode: sh -*-
#
# Settings for X11 apps

if [ -n "$DISPLAY" ]; then
    if [ -f "$HOME/.Xdefaults" ]; then
        xrdb "$HOME/.Xdefaults"
    fi
fi
