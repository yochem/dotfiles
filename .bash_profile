# old way:
# export PS1='\e[0;36m \W \e[m \e[0;35m $ \e[m '

reset=$(tput sgr0)
bold=$(tput bold)
cyan=$(tput setaf 6)
magenta=$(tput setaf 5)
white=$(tput setaf 7)

export PS1='\[$reset\]\[$cyan\] \W \[$reset\]\[$magenta\] $ \[$reset\] '
# prompt now looks like ' ~ $ '.

# gi macos gives the gitignore for macos. Use gi macos >> .gitignore to make file
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# 'cd ~/Dropbox/example' -> 'cdb example'
# cd + db = cdb
function cdb() { cd ~/Dropbox/$@ ;}

# let me know if i'm getting an error.
# Usage: $ (...some code...) kut
alias kut='|| say kut, een fout;'

# let me know when it's done (polite).
# Usage: $ ...some code... && lemmeknow
alias lemmeknow='terminal-notifier -title "Terminal" -message "Done with task!"'
