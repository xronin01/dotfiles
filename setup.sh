#!/usr/bin/env sh

if [ -n "$TERMUX_APP_PID" ]; then
  echo "" > "$PREFIX/etc/motd"
fi

## Cozette font
# curl --progress-bar -LO https://github.com/the-moonwitch/Cozette/releases/latest/download/CozetteVector.ttf -O https://github.com/the-moonwitch/Cozette/releases/latest/download/cozette_hidpi.otb
# install -v -m 600 -D CozetteVector.ttf "$HOME/.termux/font.ttf"
# install -v -m 600 -D cozette_hidpi.otb "$HOME/.local/share/fonts/cozette_hidpi.otb"
# rm -rfv CozetteVector.ttf cozette_hidpi.otb

## Maple font
curl --progress-bar -LO https://github.com/subframe7536/maple-font/releases/latest/download/MapleMono-NF-unhinted.zip
unzip -d font MapleMono-NF-unhinted.zip
install -v -m 600 -D "./font/MapleMono-NF-Regular.ttf" "$HOME/.termux/font.ttf"
install -v -m 600 -D "./font/MapleMono-NF-Regular.ttf" "$HOME/.local/share/fonts/MapleMono-NF-Regular.ttf"
rm -rfv MapleMono-NF-unhinted.zip font/

## Update symlinks
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)

update_symlink() {
  file=$1
  destination=$2
  ln -sf "$SCRIPT_DIR/$file" "$destination"
}

mkdir -pv "$HOME/.config"
mkdir -pv "$HOME/.local/bin"
mkdir -pv "$HOME/.vnc"

update_symlink termux/termux.properties "$HOME/.termux/termux.properties"
update_symlink termux/colors.properties "$HOME/.termux/colors.properties"
update_symlink scripts/startx11 "$HOME/.local/bin/startx11"
update_symlink vnc/config "$HOME/.vnc/config"
update_symlink vnc/xstartup "$HOME/.vnc/xstartup"
update_symlink shell "$HOME/.config/"
update_symlink .zshenv "$HOME/.zshenv"
update_symlink zsh "$HOME/.config/"
update_symlink tmux "$HOME/.config/"
update_symlink nvim "$HOME/.config/"
update_symlink yazi "$HOME/.config/"
update_symlink sc-im "$HOME/.config/"
update_symlink elinks "$HOME/.config/"
update_symlink aerc "$HOME/.config/"
update_symlink bat "$HOME/.config/"
update_symlink television "$HOME/.config/"
update_symlink awesome "$HOME/.config/"
update_symlink rofi "$HOME/.config/"
update_symlink wezterm "$HOME/.config/"
update_symlink alacritty "$HOME/.config/"
update_symlink mpv "$HOME/.config/"
