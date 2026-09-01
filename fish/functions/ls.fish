if type -q gls
	function ls --description 'alias ls gls --group-directories-first -A1hF --time-style +%Y-%m-%d --color=auto'
		gls --group-directories-first -A1hF --time-style +%Y-%m-%d --color=auto $argv
	end
else
	function ls --description 'alias ls ls -A1hF --color=auto $argv'
		command ls -A1hF --color=auto $argv
	end
end
