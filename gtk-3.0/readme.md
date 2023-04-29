# Notes

- Icons by [ljmil/tokyo-night-icons](https://github.com/ljmill/tokyo-night-icons/)
- Themes by [Fausto-Korpsvart/Tokyo-Night-GTK-Theme](https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme)

# Install

```sh
mkdir -p ~/.local/share/icons
cp -r ./icons/TokyoNight-SE.tar.bz2 ~/.local/share/icons/
cd ~/.local/share/icons/ && tar ./TokyoNight-SE.tar.bz2

mkdir -p ~/.themes
cp -r ./themes/Tokyonight-Storm-B/ ~/.themes/

sudo xbps-install -S lxappearance qt5-styleplugins gnome-themes-extra gtk-engine-murrine
echo 'export QT_QPA_PLATFORMTHEME=gtk2' >> ~/.bashrc

mkdir -p ~/.config/gtk-3.0
cp ./settings.ini ~/.config/gtk-3.0/
```
