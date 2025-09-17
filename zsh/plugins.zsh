## Add zsh-completions to fpath
fpath=($ZAP_PLUGIN_DIR/zsh-completions/src $fpath)

## Load tab completions for fzf-tab
autoload -U compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

setopt re_match_pcre

## zsh-vi-mode config
function zvm_config() {
  ZVM_INIT_MODE=sourcing
  ZVM_SYSTEM_CLIPBOARD_ENABLED=true
  ZVM_VI_HIGHLIGHT_BACKGROUND=#313244
  ZVM_VI_HIGHLIGHT_FOREGROUND=#cdd6f4
}

plug "Aloxaf/fzf-tab"
# plug "Freed-Wu/fzf-tab-source"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-completions"
plug "jeffreytse/zsh-vi-mode"
# plug "SleepyLeslie/zsh-vi-mode" ## fork
plug "hlissner/zsh-autopair"

## fzf-tab config
zstyle ':completion:*' menu no
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
# zstyle ':fzf-tab:*' fzf-command sk
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

## zsh-history-substring-search config
bindkey "^[[B" history-substring-search-down
bindkey "^[[A" history-substring-search-up
bindkey -M vicmd "^[[B" history-substring-search-down
bindkey -M vicmd "^[[A" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=bg=#cba6f7,fg=#cdd6f4,bold
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=bg=#f38ba8,fg=#cdd6f4,bold
