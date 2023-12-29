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
alias pytrove="curl -s 'https://pypi.org/pypi?:action=list_classifiers'"

pytree() {
    find "$1" -not -regex '.*__pycache__.*' | tree --fromfile
}

alias dds="dd status=progress oflag=sync"

# shellcheck disable=SC2142
alias diffcount="diffstat -s | awk -F, '{ gsub(/[^0-9,]/, \"\"); print \$2+\$3; }'"

alias noansi="sed -u 's/\x1b\[[0-9;]*m//g'"

alias jpgpdf="convert -compress JPEG -resize 1240x1753 -page A4 -units PixelsPerInch -density 150x150"
alias publicip="curl -s http://whatismyip.akamai.com/ && echo"
alias neofetch="curl -s https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch | bash"
