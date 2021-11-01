# Aliases


unalias -a

alias ll="ls -lFh --color=tty"
alias la="ll -A"

alias a="ag --color-match '49;31' --pager less"
alias p0="patch -p0"
alias ip="ip -c"

if [ -n "$DISPLAY" ]; then
    alias e="emacsclient -n"
else
    alias e="emacs -nw"
fi
alias ee="emacsclient -e"
alias ec="emacs -batch -f batch-byte-compile"

alias ipy="ipython3"
alias pytree='tree -P \*\.py  -I test_\*\.py -I \*\.pyc -I \*\.pyo -I \*\.egg-info -I __pycache__'
alias pytrove="curl -s 'https://pypi.org/pypi?:action=list_classifiers'"

# shellcheck disable=SC2142
alias diffcount="diffstat -s | awk -F, '{ gsub(/[^0-9,]/, \"\"); print \$2+\$3; }'"

alias noansi="sed -u 's/\x1b\[[0-9;]*m//g'"

alias jpgpdf="convert -compress JPEG -resize 1240x1753 -page A4 -units PixelsPerInch -density 150x150"
alias publicip="curl -s  http://checkip.dyn.com/ | sed 's/.* \\([0-9.]\\+\\)<.*/\\1/'"
alias neofetch="curl -s https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch | bash"
