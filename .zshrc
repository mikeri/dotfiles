# Path to your oh-my-zsh configuration.
ZSH=~/.oh-my-zsh/

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="nicoulaj"
ZSH_THEME="scc"
#ZSH_THEME="random"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export TERM=xterm-256color
export EDITOR=vim
# Workaround for mouse support in mosh:
# perl -E ' print "\e[?1005h\e[?1002h" '

PATH=$PATH:~/.gem/ruby/2.0.0/bin
export PATH
# Colorful man pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[01;38;5;155m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;253m'    # begin underline

#alias less="less -P $'\E[01;38;5;155;48;5;238m?f%f \E[00;38;5;145;48;5;238m-\E[00;38;5;145;48;5;238m .?lt\E[00;86;5;139;48;5;238mLine %lt ?Lof %L ?pt(%pt\\%)'"
alias colortest="python -c \"print('\n'.join([(' '.join([('\033[38;5;' + str((i + j)) + 'm' + str((i + j)).ljust(5) +
   '\033[0m') if i + j < 256 else '' for j in range(10)])) for i in range(0, 256, 10)]))\"" 

bindkey -v
bindkey "^[[B" history-beginning-search-forward
bindkey "^[[A" history-beginning-search-backward
