# open python server
server() { s="${1:-8000}"; open "http://localhost:$s" && python3 -m http.server "$s"; }
phpserver() { s="${1:-8000}"; open "http://localhost:$s" && php -S "localhost:$s"; }

# make a directory and cd into it
mkcd() { mkdir "$1" && cd "$1"; }

# open a manual as pdf
manpdf() { man -t "$1" | open -f -a /System/Applications/Preview.app/; }

# move to trash
thrash() { mv -f "$1" "$HOME/.Trash/$1"; }

# grep with color but output all lines
highlight() { grep --color -i -E "$1|$" "$2"; }

# go to a selected directory from the z data file
fzfz() { builtin cd "$(z | fzf | cut -d' ' -f 2- | tr -d '[[:space:]]')";  }
cdd() { builtin cd "$(fd --type d -E Library -E Pictures | fzf --height '40%' --layout reverse)";  }

# shorten pip install command
pipi() { python3 -m pip install "$1"; }

# View the local git repository on Github
# Uses alias 'git url', as seen in git/.gitconfig
# 'open' opens an url in the browser on macOS. Not tested on linux
viewgh() {
	remote=$(git ls-remote --get-url origin)
	# format: https://github.com/USER/REPO.git
	if [ ${remote:0:4} = "http" ]; then
		open "${remote}"
	# format: git://github.com/USER/REPO.git
	elif [ ${remote:0:4} = "git:" ]; then
		open "https${remote:3}"
	# format: git@github.com:USER/REPO.git
	else
		open "https:$(echo ${remote:4} | tr : /)"
	fi
}

# use the same alias for all git repos
# before I used 'dot' as alias for my dotfiles repo but that's way to confusing
g() {
	if git status &>/dev/null; then
		git "$@"
	else
		git --git-dir="$XDG_DATA_HOME/dot" --work-tree="$HOME" "$@"
	fi
}

# gi macos gives the gitignore for macos.
# Use gi macos >> .gitignore to make file
gi() { curl -L -s "https://www.gitignore.io/api/$1"; }

# echo your computers ip-address
ip() { ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'; }

# usage: clone_all_from users/username or clone_all_from orgs/orgname
clone_all_from() {
	PAGE=1;
	curl "https://api.github.com/$1/repos?page=$PAGE&per_page=100" |
	grep -e 'git_url.*' |
	cut -d \" -f 4 |
	xargs -L1 -P5 git clone;
}

# start or stop a virtual machine from the command line
vm() {
	vm_name="${2:-virtual}"

	if [ "$1" = "start" ]; then
		VBoxManage startvm "$vm_name" --type headless
	elif [ "$1" = "stop" ]; then
		VBoxManage controlvm "$vm_name" poweroff --type headless
	else
		echo "Command not found: $1"
	fi
}

# convert hex to decimal representation
hex() { echo "$((16#$1))"; }

# start working on latex project
hw() { open "$1.pdf"; app-switch; "$EDITOR" "$1.tex"; }

# find ip of router (used to ssh to it: ssh yochem@$(router))
router() { ifconfig | grep 'inet ' | grep -v '127' | cut -d ' ' -f 2; }
