[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
xrandr -s 1920x1080

$HOME/bin/mode $(cat $HOME/.theme)

exec herbstluftwm --locked
