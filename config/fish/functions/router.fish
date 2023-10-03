function router
	ifconfig | grep 'inet ' | grep -v 127 | cut -d ' ' -f 2
end
