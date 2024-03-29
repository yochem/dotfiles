# because some apps love to have their config files in the home directory,
# but I don't
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"

if [ "$(uname -s)" = Darwin ]; then
	export XDG_CACHE_HOME="$HOME/Library/Caches"
else
	export XDG_CACHE_HOME="$HOME/.cache"
fi

export ATOM_HOME="$XDG_CONFIG_HOME/atom"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export GHCUP_USE_XDG_DIRS="1"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export HISTFILE="$XDG_DATA_HOME/bash/history"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export IPYTHONDIR="$XDG_DATA_HOME/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export LESSHISTFILE="$XDG_DATA_HOME/less/history"
export MPLCONFIGDIR="$XDG_CACHE_HOME/matplotlib"
export MYPY_CACHE_DIR="$XDG_CACHE_HOME/mypy"
export NLTK_DATA="$XDG_DATA_HOME/nltk"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export PYLINTRC="$XDG_CONFIG_HOME/pylint/config"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/pycache"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
export TEXMFHOME="$XDG_CONFIG_HOME/texmf"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export _Z_DATA="$XDG_DATA_HOME/z/z_data"
