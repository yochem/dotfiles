if not set -q XDG_CONFIG_HOME
	echo "XDG_CONFIG_HOME is not set. Fish config not loaded."
	echo "Run 'set -xU XDG_CONFIG_HOME $HOME/.config' first"
	return
end

set -l vars_file "$XDG_CONFIG_HOME/fish/init-vars.fish"
set -l vars_hash (md5 -q $vars_file 2>/dev/null || md5sum $vars_file | cut -d' ' -f1)

if test "$vars_hash" != "$_vars_hash"
    source $vars_file
    set -Ux _vars_hash $vars_hash
end

if not status is-interactive
	return
end

# suppress "Last login" message
printf '\33c\e[3J'

set -U fish_greeting
set -g fish_key_bindings fish_vi_key_bindings
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

abbr -a -- cp 'cp -i'
abbr -a -- mv 'mv -i'
abbr -a -- rm 'rm -v'
abbr -a -- vi 'nvim'
abbr -a -- grep 'grep -iE'
abbr -a -- less 'less -R'

abbr -a -- reload 'exec fish'
abbr -a -- g git
abbr -a -- .. 'cd ..'
abbr -a -- perms 'stat -f %OLp'
abbr -a -- gs 'git status -s'
abbr -a --position anywhere --set-cursor='%' -- cfg "$XDG_CONFIG_HOME/%"
abbr -a --position anywhere --function last_history_item -- !!

# set tabs used by cat etc. to width 4
tabs -p
