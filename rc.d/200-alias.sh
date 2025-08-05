# Aliases


unalias -a

alias ll="ls -lFh --color=tty"
alias la="ll -A"

r() {
    rg -p "$@" | less -R
}

alias e="emacsclient -n"
alias ee="emacsclient -e"
alias ec="emacs -batch -f batch-byte-compile"
alias enw="emacsclient -q -nw"

alias ipy="ipython3"

pytree() {
    find "$1" -not -regex '.*__pycache__.*' | tree --fromfile
}

delpyc() {
    find "$@" -type d -name __pycache__ -print0 | xargs --null rm -rf
    find "$@" -name \*.pyc -exec rm {} \;
}

alias dds="dd status=progress oflag=sync"

alias noansi="sed -u 's/\x1b\[[0-9;]*m//g'"

alias jpgpdf="convert -compress JPEG -resize 1240x1753 -page A4 -units PixelsPerInch -density 150x150"

deltilde() {
    find "$@" -name \*~ -exec rm {} \;
}
