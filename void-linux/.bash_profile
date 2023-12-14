# .bash_profile

HOUR=$(date '+%H')

([ "$HOUR" -gt 17 ] || [ "$HOUR" -lt 6 ]) && THEME_MODE=dark || THEME_MODE=light

echo $THEME_MODE > ~/.theme

[ ! -s ~/.config/mpd/pid ] && mpd
[ $(pgrep mpd-mpris) ] || \
    /home/d0ublew/.local/bin/mpd-mpris -network unix \
        -host /home/d0ublew/.config/mpd/socket > /tmp/mpd-mpris.log 2>&1 &

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

. "$HOME/.cargo/env"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

([ -n "$XRDP_SESSION" ] && export DESKTOP_SESSION=herbstluftwm) || \
    pgrep xinit >/dev/null || startx

# [[ "$(tty)" == "/dev/tty1" ]] && [[ -z "$DISPLAY" ]] && startx
