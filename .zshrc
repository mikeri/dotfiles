# --- mikeris zshrc -------------------------------------------------

# Fortune to read while everything sets up. Fold long lines to terminal width.
if type "fortune" > /dev/null; then
    COLS=`tput cols`
    COLS=$((COLS-2))
    fortune | fold -s -w $COLS
fi

# --- Flatpak --------------------------------------------------------
PATH=$PATH:/var/lib/flatpak/exports/bin
plugins=(flatpak)

# --- base (oh-my-)zsh seutp ----------------------------------------
ZSH=~/.oh-my-zsh/
ZSH_THEME="scc"
# CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins+=(zsh-syntax-highlighting history-substring-search)

source $ZSH/oh-my-zsh.sh
bindkey -v

# --- Android stuff -------------------------------------------------
ANDROID_HOME=/home/mikeri/Development/Android/androidsdk 
# PATH=${PATH}:${ANDROID_HOME}/tools 
PATH=${PATH}:/home/mikeri/Development/Android/platform-tools 
# PATH=$PATH:~/Development/Android-SDKs/platform-tools
# --- misc customization ---------------------------------------------
export EDITOR=vim
# Workaround for mouse support in mosh:
# perl -E ' print "\e[?1005h\e[?1002h" '

PATH=$PATH:~/.gem/ruby/2.0.0/bin
# PATH=~/.local/bin:$PATH
export PATH
# Colorful man pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[01;38;5;155m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;253m'    # begin underline

# --- aliases and functions------------------------------------------
#alias less="less -P $'\E[01;38;5;155;48;5;238m?f%f \E[00;38;5;145;48;5;238m-\E[00;38;5;145;48;5;238m .?lt\E[00;86;5;139;48;5;238mLine %lt ?Lof %L ?pt(%pt\\%)'"
alias colortest="python -c \"print('\n'.join([(' '.join([('\033[38;5;' + str((i + j)) + 'm' + str((i + j)).ljust(5) +
   '\033[0m') if i + j < 256 else '' for j in range(10)])) for i in range(0, 256, 10)]))\"" 
alias upgr="sudo apt-get update && sudo apt-get -y full-upgrade"

new() {
    ls -lth $@ | head -11 | tail
}

compdef _files new

sid() {
    cd ~/Music/C64Music
    sidplayfp -t0 $(fzf)
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
