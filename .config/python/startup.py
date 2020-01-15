import os
import atexit
import readline
import sys
sys.path.append('/usr/local/lib/python3.7/site-packages')

try:
    from xdg import XDG_DATA_HOME
except ImportError:
    exit()

readline_history_file = os.path.join(XDG_DATA_HOME, 'python', 'history')

try:
    readline.read_history_file(readline_history_file)
except IOError:
    pass

readline.set_history_length(1000000)
atexit.register(readline.write_history_file, readline_history_file)

