# -*- mode: sh -*-
#
# Aliases
#

unalias -a

alias ll="ls -lFh --color=tty"
alias la="ll -A"

alias grep="grep --color=auto"
alias a="ack-grep"
alias p0="patch -p0"
alias tmux="tmux -2"
alias clip="xsel --clipboard"

if [ "$DISPLAY" ]; then
    alias e="emacsclient -n"
else
    alias e="emacs -nw"
fi
alias ee="emacsclient -e"
alias ec="emacs -batch -f batch-byte-compile"

alias ipy="ipython3"
alias spy="python setup.py"

alias diffcount="diffstat -s | awk -F, '{ gsub(/[^0-9,]/, \"\"); print \$2+\$3; }'"

alias jpgpdf="convert -compress JPEG -resize 1240x1753 -page A4  -units PixelsPerInch -density 150x150"
alias publicip="wget -q  http://checkip.dyn.com/ -O - | sed 's/.* \([0-9.]\+\)<.*/\1/'"
