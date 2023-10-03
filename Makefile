define \n


endef

ifndef XDG_CONFIG_HOME
$(error XDG_CONFIG_HOME is undefined)
endif

ifndef XDG_DATA_HOME
$(error XDG_DATA_HOME is undefined)
endif

################################################################################
# Per-directory Make targets (copy for new every new dir)
################################################################################
CONFIG_SRCS := $(notdir $(wildcard config/*))

config: $(addprefix $(XDG_CONFIG_HOME)/, $(CONFIG_SRCS))

$(XDG_CONFIG_HOME)/%: config/%
	@mkdir -p $(XDG_CONFIG_HOME)
	ln -sf $(realpath $^) $@

clean-config:
	$(foreach file, $(addprefix $(XDG_CONFIG_HOME)/, $(CONFIG_SRCS)), unlink $(file) 2>/dev/null || true${\n})

.PHONY: config clean-config

################################################################################

DATA_SRCS := $(notdir $(wildcard data/*))

data: $(addprefix $(XDG_DATA_HOME)/, $(DATA_SRCS))

$(XDG_DATA_HOME)/%: data/%
	@mkdir -p $(XDG_DATA_HOME)
	ln -sf $(realpath $^) $@

clean-data:
	$(foreach file, $(addprefix $(XDG_DATA_HOME)/, $(DATA_SRCS)), unlink $(file) 2>/dev/null || true${\n})

.PHONY: data clean-data

################################################################################

BIN_SRCS := $(notdir $(wildcard bin/*))
BIN_DEST_DIR := ~/.local/bin

bin: $(addprefix $(BIN_DEST_DIR)/, $(BIN_SRCS))

$(BIN_DEST_DIR)/%: bin/%
	@mkdir -p $(BIN_DEST_DIR)
	ln -sf $(realpath $^) $@

clean-bin:
	$(foreach file, $(addprefix $(BIN_DEST_DIR)/, $(BIN_SRCS)), unlink $(file) 2>/dev/null || true${\n})

.PHONY: bin clean-bin

################################################################################

HOME_SRCS := $(notdir $(wildcard home/*))

home: $(addprefix ~/., $(HOME_SRCS))

~/.%: home/%
	ln -sf $(realpath $^) $@

clean-home:
	$(foreach file, $(addprefix ~/., $(HOME_SRCS)), unlink $(file) 2>/dev/null || true${\n})

.PHONY: home clean-home

################################################################################

mac: $(wildcard Library/*/*)
ifeq ($(shell uname),Darwin)
	@for file in $^; do ln -sf "./$$file" "~/$$file"; done
endif

# NOTE: no need for a clean-mac target

.PHONY: mac

################################################################################

all: config data bin home mac

# hack to only build if file exists, || true makes sure no error is raised
%:
	@[ -e config/$@ ] && $(MAKE) --no-print-directory $(XDG_CONFIG_HOME)/$@ || true
	@[ -e data/$@ ] && $(MAKE) --no-print-directory $(XDG_DATA_HOME)/$@ || true
	@[ -e bin/$@ ] && $(MAKE) --no-print-directory $(BIN_DEST_DIR)/$@ || true
	@[ -e home/$@ ] && $(MAKE) --no-print-directory ~/.$@ || true

clean: clean-config clean-data clean-bin clean-home

.PHONY: all clean
