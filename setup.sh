#!/usr/bin/env sh

echo "" > "$PREFIX/etc/motd"

### Cozette font
font_url=$(curl -s https://api.github.com/repos/slavfox/Cozette/releases/latest | grep "CozetteVector.ttf" | cut -d\" -f4 | grep "https")
curl -L -o font.ttf "$font_url"
install -v -m 600 -D font.ttf "$HOME/.termux/font.ttf"
install -v -m 600 -D font.ttf "$HOME/.local/share/fonts/CozetteVector.ttf"
rm -rf font.ttf

### Update symlinks
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)

update_symlink() {
  file=$1
  destination=$2

  if [ ! -d "$(dirname "$destination")" ]; then
    mkdir -pv "$(dirname "$destination")"
  fi
  ln -sf "$SCRIPT_DIR/$file" "$destination"
}

# update_symlink termux/termux.properties "$HOME/.termux/termux.properties"
update_symlink termux/colors.properties "$HOME/.termux/colors.properties"
update_symlink scripts/game2chd "$HOME/.local/bin/game2chd"
update_symlink scripts/startx11 "$HOME/.local/bin/startx11"
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
