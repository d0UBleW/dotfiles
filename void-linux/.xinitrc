$HOME/bin/mode $(cat $HOME/.theme)

pamixer --set-volume 50

picom &

/home/d0ublew/.config/eww/bar/launch_bar
# /home/d0ublew/.local/bin/eww daemon
# /home/d0ublew/.local/bin/eww open bar

xrandr -s 1920x1080
exec dbus-run-session -- /bin/herbstluftwm --locked
