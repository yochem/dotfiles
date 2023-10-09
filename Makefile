ifndef XDG_CONFIG_HOME
$(error XDG_CONFIG_HOME is undefined)
endif

ifndef XDG_DATA_HOME
$(error XDG_DATA_HOME is undefined)
endif

DIRS = config data bin home
DEST_config := $(XDG_CONFIG_HOME)
DEST_data := $(XDG_DATA_HOME)
DEST_bin := ~/.local/bin
DEST_home := ~
DESTS = $(DEST_config) $(DEST_data) $(DEST_bin) $(DEST_home)

# config|data|bin
$(DIRS) : % :
	@$(MAKE) $(addprefix $(DEST_$@)/, $(notdir $(wildcard $@/*)))

.PHONY: $(DIRS)

# prog-specific
$(addsuffix /%, $(DESTS)):
	@test -n "$(realpath $(wildcard */$(notdir $@)))"
	@mkdir -p $(dir $@)
	ln -sf $(realpath $(wildcard */$(notdir $@))) $@
	@[ $(dir $@) = "$$HOME/" ] && mv $@ ~/.$(notdir $@) || true

# start tracking programs, e.g. track-config prog=nvim
prog ?= $(error Please provide a program name)
$(addprefix track-, $(DIRS)) : track-% :
	command mv $(DEST_$*)/$(prog) $*/$(prog)
	@$(MAKE) --no-print-directory $(DEST_$*)/$(prog)
	git add $*/$(prog)
	git commit -m "Add: $*/$(prog)"

# clean function
$(addprefix clean-, $(DIRS)) : clean-% :
	rm $(addprefix $(DEST_$*)/, $(notdir $(wildcard $*/*)))

clean: $(addprefix clean-, $(DIRS))

all: $(DIRS)

mac: $(wildcard Library/Preferences/*)
ifeq ($(shell uname),Darwin)
	# TODO: fix
	for file in $^; do ln -sf "$(realpath $$file)" "$$HOME/$$file"; done
	@echo Installing Brew
	xcode-select --install
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle
endif

# NOTE: no need for a clean-mac target

.PHONY: all clean mac

# hack to only build if file exists, || true makes sure no error is raised
%:
	@[ -e config/$@ ] && $(MAKE) --no-print-directory $(XDG_CONFIG_HOME)/$@ || true
	@[ -e data/$@ ] && $(MAKE) --no-print-directory $(XDG_DATA_HOME)/$@ || true
	@[ -e bin/$@ ] && $(MAKE) --no-print-directory $(BIN_DEST_DIR)/$@ || true
	@[ -e home/$@ ] && $(MAKE) --no-print-directory ~/.$@ || true
