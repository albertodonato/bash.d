# Settings for X11 apps

if [ -n "$DISPLAY" ]; then
    if [ -f "$HOME/.Xresources" ]; then
        xrdb "$HOME/.Xresources"
    fi
fi
