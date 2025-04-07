## If the zap directory does not exist, install zap
if [[ ! -d $HOME/.local/share/zap ]]; then
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
fi

## Source
source "$ZDOTDIR/.zprompt.zsh"
source "$ZDOTDIR/.zfunctions.zsh"

## Aliases
alias ls="eza --icons --group-directories-first"
alias ll="ls -l --git"
alias la="ll -a"
alias tree="ll --tree --level=2"
alias grep="grep --color=auto"
alias cp="cp --interactive"
alias mv="mv --interactive"
alias rm="rm --interactive"
alias ..="cd .."
alias ...="cd ../.."
alias cmeta="exiftool -all= -overwrite_original $@"
alias cat="bat -pp"
alias bc=bc-gh
alias dc=dc-gh
alias vim=$EDITOR
alias news=newsboat
alias cls=clear

## History
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

## Load tab completions
autoload -U compinit && compinit -d $ZCOMPDUMP

## Fix vi plugin conflicting with fzf
export ZVM_INIT_MODE=sourcing

## Plugins
source "$HOME/.local/share/zap/zap.zsh"
plug "Aloxaf/fzf-tab"
# plug "Freed-Wu/fzf-tab-source"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-completions"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
# plug "jeffreytse/zsh-vi-mode"
plug "SleepyLeslie/zsh-vi-mode" ## fork

## Load autopairs plugin
autopair-init

## Tab completion styling
zstyle ':completion:*' menu no
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
# zstyle ':fzf-tab:*' fzf-command sk
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --color=always --group-directories-first $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --icons --color=always --group-directories-first $realpath'

## Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"
# eval "$(starship init zsh)"
