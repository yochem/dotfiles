function server
	[ -n $argv[1] ] && set s $argv[1] || set s 8000
	open "http://localhost:$s" && python3 -m http.server "$s"
end
