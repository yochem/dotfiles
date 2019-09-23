autoload -U colors && colors

# load some more configs
dotfiles=(
    ~/.config/shell/xdg
    "$XDG_CONFIG_HOME"/shell/exports
    "$XDG_CONFIG_HOME"/shell/aliases
    "$XDG_CONFIG_HOME"/shell/functions
    "$XDG_CONFIG_HOME"/shell/prompt
    ~/.local/bin/z.sh
    "$XDG_CONFIG_HOME"/iterm2/iterm2_shell_integration.bash
)

# Load the shell dotfiles, and z.sh
for file in ${dotfiles[@]}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
unset dotfiles

# don't reload bashrc, but zshrc
alias reload="source $ZDOTDIR/.zshrc"

# change histfile
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ "${KEYMAP}" == vicmd ]] || [[ "$1" = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ "${KEYMAP}" == main ]] ||
       [[ "${KEYMAP}" == viins ]] ||
       [[ "${KEYMAP}" = '' ]] ||
       [[ "$1" = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Load completions for Ruby, Git, etc.
autoload compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
