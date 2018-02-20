# Some colors to use for prompt
reset=$(tput sgr0)
bold=$(tput bold)
cyan=$(tput setaf 6)
magenta=$(tput setaf 5)
white=$(tput setaf 7)

export PS1='\[$reset\]\[$cyan\] \W \[$reset\]\[$magenta\] $ \[$reset\] ';
# prompt now looks like ' ~ $ '.

export EDITOR=/usr/local/bin/atom

# Load the shell dotfiles, and then some:
for file in ~/.{aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
