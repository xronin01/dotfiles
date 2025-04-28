autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep '??' &> /dev/null ; then
    hook_com[staged]+='!' # signify new files with a bang
  fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "%{$fg[magenta]%} %b %{$fg[red]%}%m%u%c"

# machine="%{$fg[cyan]%}%m"
directory="%{$fg[blue]%} %~"
git_info="\$vcs_info_msg_0_"
status_symbol="%(?:%{$fg[green]%}❯ :%{$fg[red]%}❯ )%{$reset_color%}"

PROMPT="
${directory} ${git_info}
${status_symbol}"
