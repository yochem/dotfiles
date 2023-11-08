if set -q TMUX
  set -e ITERM_PROFILE
end
fish_vi_key_bindings
set -g fish_vi_force_cursor 1

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore

set -g fish_color_command blue
set -g fish_color_comment 6f7683
set -g fish_color_quote green
set -g fish_color_redirection magenta
set -g fish_color_autosuggestion 6f7683

[ -z "$XDG_CONFIG_HOME" ] && echo "XDG_CONFIG_HOME not set!!!"
source "$HOME/.config/fish/xdg.fish"
source "$HOME/.config/fish/prompt.fish"
source "$HOME/.config/fish/exports.fish"

abbr reload "exec fish"
abbr g git
abbr .. "cd .."
abbr pip python3 -m pip
abbr perms stat -f '%OLp'
abbr gs "git status -s"

[ -n (command -v nvim) ] && alias vim nvim

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
