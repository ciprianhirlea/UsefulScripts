gsettings set org.gnome.nautilus.icon-view default-zoom-level small
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$// ), 'org.gnome.Terminal.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop']"

snap install notepad-plus-plus
apt-get install filezilla
