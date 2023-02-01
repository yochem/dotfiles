# open python server
function server
	[ -n $argv[1] ] && set s $argv[1] || set s 8000
	open "http://localhost:$s" && python3 -m http.server "$s"
end

function phpserver
	[ -n $argv[1] ] && set s $argv[1] || set s 8000
	open "http://localhost:$s" && php -S "localhost:$s"
end

# make a directory and cd into it
function mkcd
	mkdir $argv[1] && cd $argv[1]
end

# move to trash
function thrash
	mv -f $argv[1] "$HOME/.Trash/"$argv[1]
end

# shorten pip install command
abbr pip python3 -m pip

# use the same alias for all git repos
# before I used 'dot' as alias for my dotfiles repo but that's way to confusing
function g
	if git status &>/dev/null
		git $argv
	else
		git --git-dir="$XDG_DATA_HOME/dot" --work-tree="$HOME" $argv
	end
end

# echo your computers ip-address
function ip
	ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
end

# usage: clone_all_from users/username or clone_all_from orgs/orgname
function clone_all_from
	set PAGE 1
	curl "https://api.github.com/"$argv[1]"/repos?page=$PAGE&per_page=100" |
		grep -e 'git_url.*' |
		cut -d \" -f 4 |
		xargs -L1 -P5 git clone
end

# find ip of router (used to ssh to it: ssh yochem@(router))
function router
	ifconfig | grep 'inet ' | grep -v 127 | cut -d ' ' -f 2
end

function fish_title
	[ -z $TMUX ] && return
	if [ fish != $_ ]
		tmux rename-window "$_"
	else
		set basename (string lower (basename (pwd)))
		if [ $basename = "yochem" ]
			tmux rename-window "home/"
		else if [ $basename = "/" ]
			tmux rename-window "/"
		else
			tmux rename-window "$basename/"
		end
	end
	# tmux set-option automatic-rename on
end

function appify
	"/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" --app=$argv[1]
end

function airpods
	blueutil --connect e4-76-84-50-e8-07
end

function startpyenv
	status is-login; and pyenv init --path --no-rehash | source
	status is-login; and pyenv virtualenv-init - | source
end

function line -e fish_prompt -d "print line after command to seperate commands"
	set_color brblack
	jot -b '–' -s '' $COLUMNS 2>/dev/null
end

function sortlist
	echo $argv[1] |tr $argv[2] '\n' | sort -b |  paste -s -d $argv[2] -
end

function ztest
	set output (/Users/yochem/Documents/z-v/z $argv)

	if test (count $output) -eq 1
		cd $output 2>&1 >/dev/null
	else
		printf "%s\n" $output
	end
end