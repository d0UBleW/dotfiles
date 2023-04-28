[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
xrandr -s 1920x1080

HOUR=$(date '+%H')

([ "$HOUR" -gt 17 ] || [ "$HOUR" -lt 6 ]) && MODE=dark || MODE=light

$HOME/bin/mode $MODE

exec herbstluftwm --locked
