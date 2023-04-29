# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
# [[ "$(tty)" == "/dev/tty1" ]] && ([[ $(pgrep startx) ]] || startx)

HOUR=$(date '+%H')

([ "$HOUR" -gt 17 ] || [ "$HOUR" -lt 6 ]) && THEME_MODE=dark || THEME_MODE=light

echo $THEME_MODE > ~/.theme

[[ "$(tty)" == "/dev/tty1" ]] && [[ -z "$DISPLAY" ]] && startx
