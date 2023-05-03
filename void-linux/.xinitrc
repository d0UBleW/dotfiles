[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
xrandr -s 1920x1080

$HOME/bin/mode $(cat $HOME/.theme)

[ ! -s ~/.config/mpd/pid ] && mpd

exec dbus-run-session -- herbstluftwm --locked
