function xdg
	switch $argv[1]
	case config
		echo "$XDG_CONFIG_HOME"
	case data
		echo "$XDG_DATA_HOME"
	case cache
		echo "$XDG_CACHE_HOME"
	case state
		echo "$XDG_STATE_HOME"
	end
end

complete -c xdg -x -a "config data cache state"
