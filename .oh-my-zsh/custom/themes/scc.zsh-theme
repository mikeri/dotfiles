RPROMPT='%{${fg[yellow]}%}%n%{$reset_color%}%{${FG[240]}%}@%{${fg[blue]}%}%m%{$reset_color%}%(?,,%{${fg_bold[red]}%} [%?]%{$reset_color%})%{$reset_color%}'
PROMPT='%{$fg[cyan]%}%~%{$fg_bold[yellow]%}> %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
