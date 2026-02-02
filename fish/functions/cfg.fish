function cfg
	set cfgdir "$HOME/Documents/dotfiles/config/"
	set fzfopts "--height 40% --layout reverse --select-1 --exit-0"
	set fdopts "--max-depth 5 --type file --relative-path --full-path"

	# $1=git, then open ~/.config/git/config
	[ -f "$cfgdir/$1/config" ] && nvim "$cfgdir/$1/config" && exit
	fd $fdopts "$1" "$cfgdir" | fzf $fzfopts | xargs nvim
end
