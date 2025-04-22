if set -q TMUX
  set -e ITERM_PROFILE
end
fish_vi_key_bindings
set -g fish_vi_force_cursor 1

set fish_cursor_unknown block
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore

set -g fish_color_command blue
set -g fish_color_comment 6f7683
set -g fish_color_quote green
set -g fish_color_redirection magenta
set -g fish_color_autosuggestion 6f7683

[ -z "$XDG_CONFIG_HOME" ] && echo "XDG_CONFIG_HOME not set!!!"
source "$XDG_CONFIG_HOME/fish/xdg.fish"
source "$XDG_CONFIG_HOME/fish/prompt.fish"

source "$HOME/Documents/venvs/venvs.fish"

abbr reload "exec fish"
abbr g git
abbr .. "cd .."
abbr pip python3 -m pip
abbr tlmgr "sudo tlmgr install"
abbr perms stat -f '%OLp'
abbr gs "git status -s"

function last_history_item
	echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item

# choose the default editor
if command -v nvim >/dev/null 2>&1
	set -xU VISUAL nvim
	set -xU MANPAGER 'nvim +Man!'
else if command -v vim >/dev/null 2>&1
	set -xU VISUAL vim
else
	set -xU VISUAL nano
end

set -xU EDITOR "$VISUAL"

# fix the bug of Apple creating a non-exisiting LC
set -xU LC_ALL "en_US.UTF-8"

set -xU FZF_DEFAULT_COMMAND 'fd --type f'

set -gx LS_COLORS (vivid generate one-dark-simple)

set -gx PLAN9 /usr/local/plan9
fish_add_path -aP $PLAN9/bin

# fd is fdfind on ubuntu
command -v fdfind >/dev/null && alias fd fdfind

# set tabs used by cat etc. to width 4
tabs -p

if [ -z "$TMUX" ] && [ -z "$SSH_CLIENT" ]
	tmux ls 2>/dev/null | grep attached >/dev/null
	if [ "$status" = 1 ]
		tmux attach-session -t general || tmux new-session -s general
	end
end
