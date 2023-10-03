# don't prepend prompt with vi command mode
function fish_mode_prompt
end

# function for showing the git branch
function prompt_git
	git rev-parse --is-inside-work-tree &>/dev/null
	if [ "$status" = 0 ]
		set branchName (git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo -e '(unknown)')
		printf " ("
		set_color green
		printf "$branchName"
		set_color normal
		printf ") "
	else
		printf " "
	end
end


function line -e fish_prompt -d "print line after command to seperate commands"
	set_color brblack
	jot -b '–' -s '' $COLUMNS 2>/dev/null
end

# the prompt normally looks like this: [ ~/Documents ]
# but can look like these:
# [ @host: ~/Documents ]
# [ root ~/Documents ]
# [ root@host: ~/Documents ]
function fish_prompt
	set_color normal
	printf "[ "

	if [ "$USER" = root ]
		set_color brmagenta --bold
		printf root
		set_color normal
	end

	if [ -n "$SSH_CLIENT" ]
		set_color brmagenta
		printf "@"
		printf (prompt_hostname)
		set_color normal
		printf ": "
	end

	if [ "$USER" = root ] && [ -z "$SSH_CLIENT" ]
		printf " "
	end

	set_color blue
	set full (pwd | sed "s|$HOME|~|i")
	if [ (string length $full) -gt (math $COLUMNS / 3) ]
		echo -n (prompt_pwd)
	else
		printf $full
	end
	set_color normal

	printf (prompt_git)
	printf "] "

	z --update >/dev/null 2>&1
end
