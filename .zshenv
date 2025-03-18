export ZDOTDIR="$HOME/.config/zsh"
export ZCOMPDUMP="$HOME/.zcompdump"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
export HISTDUP=erase

export CARGO_HOME="$HOME/.local/share/cargo"
export GOPATH="$HOME/.local/share/go"
export PNPM_HOME="$HOME/.local/share/pnpm"
# export DENO_INSTALL_ROOT="$HOME/.local/share/deno"
export PATH="$PATH:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin:$PNPM_HOME"

export TERMUX_X11_XSTARTUP=awesome
# export TERMINFO=/data/data/com.termux/files/usr/share/terminfo

export EDITOR=nvim
export VISUAL=$EDITOR
# export GTERM=wezterm
# export TERMCMD="wezterm start --always-new-process"
export GTERM=alacritty
export TERMCMD="alacritty"
export BROWSER=elinks
export PAGER="less -R"
export MANPAGER="nvim +Man!"

export LESSHISTFILE=-
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export BAT_STYLE="numbers,changes,header"
export BAT_THEME="Catppuccin Mocha"

export SKIM_DEFAULT_OPTIONS="--layout=reverse"
export SKIM_DEFAULT_OPTIONS="$SKIM_DEFAULT_OPTIONS \
--color=fg:#cdd6f4,bg:#1e1e2e,matched:#313244,matched_bg:#f2cdcd,current:#cdd6f4,current_bg:#45475a,current_match:#1e1e2e,current_match_bg:#f5e0dc,spinner:#a6e3a1,info:#cba6f7,prompt:#89b4fa,cursor:#f38ba8,selected:#eba0ac,header:#94e2d5,border:#6c7086"

export FZF_DEFAULT_OPTS="--layout=reverse \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
