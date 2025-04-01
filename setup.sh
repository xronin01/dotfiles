#!/usr/bin/env sh

if echo "$PREFIX" | grep -q "com.termux"; then
  echo "" > "$PREFIX/etc/motd"
fi

## Cozette font
release_info=$(curl -s https://api.github.com/repos/slavfox/Cozette/releases/latest)
font_ttf=$(echo "$release_info" | grep -o "https://github.com/slavfox/Cozette/releases/download/v.*/CozetteVector.ttf")
font_otb=$(echo "$release_info" | grep -o "https://github.com/slavfox/Cozette/releases/download/v.*/cozette.otb")
curl --progress-bar -L -O "$font_ttf" -O "$font_otb"
install -v -m 600 -D CozetteVector.ttf "$HOME/.termux/font.ttf"
install -v -m 600 -D cozette.otb "$HOME/.local/share/fonts/cozette.otb"
rm -rf CozetteVector.ttf cozette.otb

## Update symlinks
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)

update_symlink() {
  file=$1
  destination=$2

  ln -sf "$SCRIPT_DIR/$file" "$destination"
}

mkdir -pv "$HOME/.config"

# update_symlink termux/termux.properties "$HOME/.termux/termux.properties"
update_symlink termux/colors.properties "$HOME/.termux/colors.properties"
update_symlink scripts/game2chd "$HOME/.local/bin/game2chd"
update_symlink scripts/startx11 "$HOME/.local/bin/startx11"
update_symlink vnc/config "$HOME/.vnc/config"
update_symlink vnc/xstartup "$HOME/.vnc/xstartup"
update_symlink .zshenv "$HOME/.zshenv"
update_symlink zsh "$HOME/.config/"
update_symlink hilbish "$HOME/.config/"
update_symlink tmux "$HOME/.config/"
update_symlink nvim "$HOME/.config/"
update_symlink yazi "$HOME/.config/"
update_symlink sc-im "$HOME/.config/"
update_symlink elinks "$HOME/.config/"
update_symlink newsboat "$HOME/.config/"
update_symlink bat "$HOME/.config/"
update_symlink fastfetch "$HOME/.config/"
update_symlink awesome "$HOME/.config/"
update_symlink wezterm "$HOME/.config/"
