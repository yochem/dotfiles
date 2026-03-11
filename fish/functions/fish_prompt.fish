function prompt_line --description 'print line after command to seperate commands' --on-event fish_prompt
	set_color brblack
	string repeat -n $COLUMNS '─'
end

function prompt_hostname --description 'short hostname for the prompt'
    string replace -r -- "\..*" "" $hostname
end

# Examples: (`|` represents the cursor)
# [ ~/Documents ] |
# [ ~/Documents (master) ] |
# [ @host: ~/Documents ] |
# [ root ~/Documents ] |
# [ root@host: ~/Documents ] |
function fish_prompt
	if not status is-interactive
		return
	end
	set_color normal
	printf "[ "

	if [ "$USER" = root ]
		set_color brmagenta --bold
		printf root
		set_color normal
	end

	if set -q SSH_CLIENT
		set_color brmagenta
		printf "@$(prompt_hostname)"
		set_color normal
		printf ": "
	end

	if [ "$USER" = root ] && set -q SSH_CLIENT
		printf " "
	end

	set_color blue
	set full (string replace $HOME '~' $PWD)
	if [ (string length $full) -gt (math $COLUMNS / 3) ]
		echo -n (prompt_pwd)
	else
		printf $full
	end
	set_color normal

	set_color green
	printf (fish_git_prompt)
	set_color normal

	printf " ] "
end
