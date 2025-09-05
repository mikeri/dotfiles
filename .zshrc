# --- mikeris zshrc -------------------------------------------------

# Fortune to read while everything sets up. Fold long lines to terminal width.
if type "fortune" > /dev/null; then
    COLS=`tput cols`
    COLS=$((COLS-2))
    fortune | fold -s -w $COLS
fi

# --- Flatpak --------------------------------------------------------
PATH=$PATH:/var/lib/flatpak/exports/bin

# --- zinit ----------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
zinit load "zsh-users/zsh-syntax-highlighting"
zinit load "zsh-users/zsh-history-substring-search"
zinit load "zsh-users/zsh-completions"
zinit load "bilelmoussaoui/flatpak-zsh-completion"
zinit load 'endaaman/lxd-completion-zsh'

# --- prompt --------------------------------------------------------
setopt prompt_subst
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ''        # No indicator for staged changes
zstyle ':vcs_info:*' unstagedstr 'x'     # Indicator for unstaged changes
zstyle ':vcs_info:*' formats '%F{240}(%F{246}%b%F{240})%F{red}%u%f '
zstyle ':vcs_info:*' actionformats '%F{240}(%F{246}%b%F{240})%F{red}%u%f '

precmd() { vcs_info 2>/dev/null }

PROMPT='%F{240}%25<...<%F{cyan}%~%F{yellow}%B>%b%f '
RPROMPT='${vcs_info_msg_0_}%F{yellow}%n%f%F{240}@%F{blue}%m%f%(?,,%F{red} [%?]%f)'

# --- Android stuff -------------------------------------------------
ANDROID_HOME=/home/mikeri/Development/Android/androidsdk 
# PATH=${PATH}:${ANDROID_HOME}/tools 
PATH=${PATH}:/home/mikeri/Development/Android/platform-tools 
# PATH=$PATH:~/Development/Android-SDKs/platform-tools

# --- misc config/customization -------------------------------------
#set history size
export HISTSIZE=100000
#save history after logout
export SAVEHIST=100000
#history file
export HISTFILE=~/.zhistory
#append into history file
setopt INC_APPEND_HISTORY
#share history accress sessions
setopt SHARE_HISTORY
#save only one command if 2 are same
setopt HIST_IGNORE_ALL_DUPS
#add timestamp for each entry
setopt EXTENDED_HISTORY 
#directory completeion
setopt AUTOCD
#keep trailing slash when autocompleting dirs
setopt NO_AUTO_REMOVESLASH
#prevent commands prefixed with space to be stored in history
setopt HIST_IGNORE_SPACE

HISTFILE=~/.zsh_history
# DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
bindkey -v
bindkey "^Q" push-line

export LD_PRELOAD=""
if command -v nvim > /dev/null
then
    export EDITOR=nvim
fi

# Set TERM on macOS because of problems with ssh
if [[ `uname` == "Darwin" ]]
then
    export TERM=xterm-256color
fi

# Workaround for mouse support in mosh:
# perl -E ' print "\e[?1005h\e[?1002h" '

# PATH=~/.local/bin:$PATH
# export PATH
#
# Less colors
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[01;38;5;155m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;253m'    # begin underline
# Less options
export LESS="-j 4 -i"

# --- completion, ripped from oh-my-zsh ---------------------------
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

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

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
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
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

# --- aliases and functions------------------------------------------
alias colortest="python -c \"print('\n'.join([(' '.join([('\033[38;5;' + str((i + j)) + 'm' + str((i + j)).ljust(5) +
   '\033[0m') if i + j < 256 else '' for j in range(10)])) for i in range(0, 256, 10)]))\"" 
alias upgr="sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get autoremove"
alias nfocat="iconv -f cp437"
alias ncdu="ncdu --color dark -x"
alias ls='ls --color=tty'
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

terminfo-export() {
    # Quickly export current terminfo to remote server
    infocmp | ssh "$1" "tic -x /dev/stdin"
}

function ranger {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command
        ranger
        --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )
    
    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}

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

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi


[ -f /home/mikeri/.shelloracle.zsh ] && source /home/mikeri/.shelloracle.zsh