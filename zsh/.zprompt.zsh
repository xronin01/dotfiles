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
# Apply color to vsc_info in prompt
# %m - name of current branch
# %u - status of current branch
# %c - number of commits ahead/behind the upstream branch
zstyle ':vcs_info:git:*' formats "%{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[cyan]%} %b%{$fg[blue]%})%{$reset_color%}"

machine="%{$fg[blue]%}%m%{$reset_color%}"
relativeHome="%{$fg[green]%}%~%{$reset_color%}"
git_info="\$vcs_info_msg_0_"

PROMPT="${relativeHome} ${git_info}%# "
