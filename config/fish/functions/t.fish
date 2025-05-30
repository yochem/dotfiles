function t
	set cmd 'command ls ~/Documents | fzf --tmux --tac -0 -1'
	if set -q argv[1]
		set cmd "$cmd --query $argv[1]"
	end
	set selected (eval $cmd)
	if test -z $selected
		return
	end

	set name (basename $selected | tr . _)

	if test -z $TMUX -a -z (pgrep tmux)
		tmux new-session -s $selected_name -c ~/Documents/$selected
		return
	end

	if ! tmux has-session -t=$name 2>/dev/null
		tmux new-session -ds $name -c ~/Documents/$selected
	end

	tmux switch-client -t $name
end
