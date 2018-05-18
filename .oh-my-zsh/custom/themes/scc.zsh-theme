RPROMPT='$(git_prompt_info)%{${fg[yellow]}%}%n%{$reset_color%}%{${FG[240]}%}@%{${fg[blue]}%}%m%{$reset_color%}%(?,,%{${fg_bold[red]}%} [%?]%{$reset_color%})%{$reset_color%}'
PROMPT='%{$FG[240]%}%25<...<%{$fg[cyan]%}%~%{$fg_bold[yellow]%}> %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[240]%}(%{$FG[246]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[240]%})%{$fg[red]%}x%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[240]%})"
