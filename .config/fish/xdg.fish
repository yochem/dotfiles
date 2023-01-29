# because some apps love to have their config files in the home directory,
# but I don't
set -xU XDG_CONFIG_HOME "$HOME/.config"
set -xU XDG_DATA_HOME "$HOME/.local/share"
set -xU XDG_STATE_HOME "$HOME/.local/state"
fish_add_path "$HOME/.local/bin"

if [ (uname -s) = Darwin ]
	set -xU XDG_CACHE_HOME "$HOME/Library/Caches"
else
	set -xU XDG_CACHE_HOME "$HOME/.cache"
end

# for easier typing on the command line
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


# set -xU PYTHONSTARTUP "$XDG_CONFIG_HOME/python/startup.py"
# set -xU RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/rg/config"
set -xU BUNDLE_USER_CONFIG "$XDG_CONFIG_HOME/bundle"
set -xU CABAL_CONFIG "$XDG_CONFIG_HOME/cabal/config"
set -xU CABAL_DIR "$XDG_CACHE_HOME/cabal"
set -xU CONDA_ROOT "$XDG_DATA_HOME/conda"
set -xU DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -xU GEM_HOME "$XDG_DATA_HOME/gem"
set -xU GEM_SPEC_CACHE "$XDG_CACHE_HOME/gem"
set -xU GHCUP_USE_XDG_DIRS 1
set -xU GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -xU GOPATH "$XDG_DATA_HOME/go"
set -xU HISTFILE "$XDG_DATA_HOME/bash/history"
set -xU INPUTRC "$XDG_CONFIG_HOME/readline/inputrc"
set -xU IPYTHONDIR "$XDG_DATA_HOME/ipython"
set -xU JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME/jupyter"
set -xU LESSHISTFILE "$XDG_DATA_HOME/less/history"
set -xU MPLCONFIGDIR "$XDG_CACHE_HOME/matplotlib"
set -xU MYPY_CACHE_DIR "$XDG_CACHE_HOME/mypy"
set -xU NLTK_DATA "$XDG_DATA_HOME/nltk"
set -xU NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
set -xU PYENV_ROOT "$XDG_DATA_HOME/pyenv"
set -xU PYLINTHOME "$XDG_CACHE_HOME/pylint"
set -xU PYLINTRC "$XDG_CONFIG_HOME/pylint/config"
set -xU PYTHONPYCACHEPREFIX "$XDG_CACHE_HOME/pycache"
set -xU SCREENRC "$XDG_CONFIG_HOME/screen/screenrc"
set -xU TERMINFO "$XDG_DATA_HOME/terminfo"
set -xU TERMINFO_DIRS "$XDG_DATA_HOME/terminfo" "/usr/share/terminfo"
set -xU TEXMFHOME "$XDG_CONFIG_HOME/texmf"
set -xU VCACHE "$XDG_CACHE_HOME/v"
set -xU VMODULES "$XDG_CACHE_HOME/vmodules"
set -xU VSCODE_PORTABLE "$XDG_DATA_HOME/vscode"
set -xU ZDOTDIR "$XDG_CONFIG_HOME/zsh"
set -xU _Z_DATA "$XDG_DATA_HOME/z/z_data"
