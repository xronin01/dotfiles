## Bootstrap zap-zsh
if [[ ! -d $XDG_DATA_HOME/zap ]]; then
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
fi
source "$XDG_DATA_HOME/zap/zap.zsh"

source "$XDG_CONFIG_HOME/shell/aliases"
source "$ZDOTDIR/prompt.zsh"
source "$ZDOTDIR/options.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/plugins.zsh"

## Shell integrations
# eval "$(fzf --zsh)"
eval "$(tv init zsh)"
eval "$(zoxide init zsh --cmd cd)"
# eval "$(starship init zsh)"
