# --- mikeris zshrc -------------------------------------------------

# Fortune to read while everything sets up. Fold long lines to terminal width.
if type "fortune" > /dev/null; then
    COLS=`tput cols`
    COLS=$((COLS-2))
    fortune | fold -s -w $COLS
fi

# --- Flatpak --------------------------------------------------------
PATH=$PATH:/var/lib/flatpak/exports/bin

# --- zplug ----------------------------------------------------------
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:2
zplug "bilelmoussaoui/flatpak-zsh-completion"
zplug 'endaaman/lxd-completion-zsh'
zplug "mikeri/3c90c61ba41cc0b2c625bd0f6a908a7f", from:gist, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Uninstalled zsh plugins found! Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# --- Android stuff -------------------------------------------------
ANDROID_HOME=/home/mikeri/Development/Android/androidsdk 
# PATH=${PATH}:${ANDROID_HOME}/tools 
PATH=${PATH}:/home/mikeri/Development/Android/platform-tools 
# PATH=$PATH:~/Development/Android-SDKs/platform-tools

# --- misc config/customization -------------------------------------
#set history size
export HISTSIZE=10000
#save history after logout
export SAVEHIST=10000
#history file
export HISTFILE=~/.zhistory
#append into history file
setopt INC_APPEND_HISTORY
#save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
#add timestamp for each entry
setopt EXTENDED_HISTORY 

HISTFILE=~/.zsh_history
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
bindkey -v
bindkey "^Q" push-line

export LD_PRELOAD=""
export EDITOR=nvim
# Workaround for mouse support in mosh:
# perl -E ' print "\e[?1005h\e[?1002h" '

PATH=$PATH:~/.gem/ruby/2.0.0/bin
PATH=~/.local/bin:$PATH
export PATH
# Colorful man pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[01;38;5;155m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;253m'    # begin underline

# --- completeion, ripped from oh-my-zsh ---------------------------
# fixme - the load process here seems a bit bizarre
zmodload -i zsh/complist

WORDCHARS=''

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select

# case insensitive (all), partial-word and substring completion
if [[ "$CASE_SENSITIVE" = true ]]; then
  zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
  if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
  else
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
  fi
fi
unset CASE_SENSITIVE HYPHEN_INSENSITIVE

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

if [[ "$OSTYPE" = solaris* ]]; then
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm"
else
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
fi

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

if [[ $COMPLETION_WAITING_DOTS = true ]]; then
  expand-or-complete-with-dots() {
    # toggle line-wrapping off and back on again
    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti rmam
    print -Pn "%{%F{red}......%f%}"
    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti smam

    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi

# automatically load bash completion functions
autoload -Uz bashcompinit && bashcompinit

# --- aliases and functions------------------------------------------
#alias less="less -P $'\E[01;38;5;155;48;5;238m?f%f \E[00;38;5;145;48;5;238m-\E[00;38;5;145;48;5;238m .?lt\E[00;86;5;139;48;5;238mLine %lt ?Lof %L ?pt(%pt\\%)'"
alias colortest="python -c \"print('\n'.join([(' '.join([('\033[38;5;' + str((i + j)) + 'm' + str((i + j)).ljust(5) +
   '\033[0m') if i + j < 256 else '' for j in range(10)])) for i in range(0, 256, 10)]))\"" 
alias upgr="sudo apt-get update && sudo apt-get -y full-upgrade && sudo apt-get autoremove"
alias nfocat="iconv -f cp437"
alias ls='ls --color=tty'
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'

new() {
    ls -lth $@ | head -11 | tail
}

compdef _files new

sid() {
    cd ~/Music/C64Music
    sidplayfp -v -t0 $(fzf)
}

if type "fzf" > /dev/null; then
    historyfzf() {
        if [[ -z $BUFFER ]]; then
            entry=$(cat ~/.zsh_history|perl -pe 's/^(.+?);(.+)/\2/p'|fzf --prompt="Search history: ")
        else
            entry=$(cat ~/.zsh_history|perl -pe 's/^(.+?);(.+)/\2/p'|fzf -q$BUFFER --prompt="Search history: ")
        fi
        BUFFER=$entry
        zle end-of-line
        # zle accept-line
    }
    zle -N historyfzfwidget historyfzf
    bindkey '^r' historyfzfwidget
fi

# --- Keyboard handling, from zshwiki.org ---------------------------
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      history-substring-search-up
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    history-substring-search-down
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
