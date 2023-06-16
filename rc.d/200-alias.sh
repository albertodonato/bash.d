# Aliases


unalias -a

alias ll="ls -lFh --color=tty"
alias la="ll -A"

r() {
    rg -p "$@" | less -R
}

pytree() {
    find "$1" -not -regex '.*__pycache__.*' | tree --fromfile
}

alias e="emacsclient -n"
alias ee="emacsclient -e"
alias ec="emacs -batch -f batch-byte-compile"
alias enw="emacsclient -q -nw"

alias ipy="ipython3"
alias pytree='tree -P \*\.py  -I test_\*\.py -I \*\.pyc -I \*\.pyo -I \*\.egg-info -I __pycache__'
alias pytrove="curl -s 'https://pypi.org/pypi?:action=list_classifiers'"

# shellcheck disable=SC2142
alias diffcount="diffstat -s | awk -F, '{ gsub(/[^0-9,]/, \"\"); print \$2+\$3; }'"

alias noansi="sed -u 's/\x1b\[[0-9;]*m//g'"

alias jpgpdf="convert -compress JPEG -resize 1240x1753 -page A4 -units PixelsPerInch -density 150x150"
alias publicip="curl -s http://whatismyip.akamai.com/ && echo"
alias neofetch="curl -s https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch | bash"
