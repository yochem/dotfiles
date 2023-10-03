define \n


endef

ifndef XDG_CONFIG_HOME
$(error XDG_CONFIG_HOME is undefined)
endif

ifndef XDG_DATA_HOME
$(error XDG_DATA_HOME is undefined)
endif

CONFIG_SRCS := $(notdir $(wildcard config/*))
DATA_SRCS := $(notdir $(wildcard data/*))
BIN_SRCS := $(notdir $(wildcard bin/*))
BIN_DEST_DIR := ~/.local/bin

config: $(addprefix $(XDG_CONFIG_HOME)/, $(CONFIG_SRCS))

$(XDG_CONFIG_HOME)/%: config/%
	@mkdir -p $(XDG_CONFIG_HOME)
	ln -sf $(realpath $^) $@

data: $(addprefix $(XDG_DATA_HOME)/, $(DATA_SRCS))

$(XDG_DATA_HOME)/%: data/%
	@mkdir -p $(XDG_DATA_HOME)
	ln -sf $(realpath $^) $@

bin: $(addprefix $(BIN_DEST_DIR)/, $(BIN_SRCS))

$(BIN_DEST_DIR)/%: bin/%
	@mkdir -p $(BIN_DEST_DIR)
	ln -sf $(realpath $^) $@

mac: $(wildcard Library/*/*)
ifeq ($(shell uname),Darwin)
	@for file in $^; do ln -sf "./$$file" "~/$$file"; done
endif

all: config data bin mac

# hack to only build if file exists, || true makes sure no error is raised
%:
	@[ -e config/$@ ] && $(MAKE) --no-print-directory $(XDG_CONFIG_HOME)/$@ || true
	@[ -e data/$@ ] && $(MAKE) --no-print-directory $(XDG_DATA_HOME)/$@ || true
	@[ -e bin/$@ ] && $(MAKE) --no-print-directory $(BIN_DEST_DIR)/$@ || true

clean-config:
	$(foreach file, $(addprefix $(XDG_CONFIG_HOME)/, $(CONFIG_SRCS)), unlink $(file) 2>/dev/null || true${\n})

clean-data:
	$(foreach file, $(addprefix $(XDG_DATA_HOME)/, $(DATA_SRCS)), unlink $(file) 2>/dev/null || true${\n})

clean-bin:
	$(foreach file, $(addprefix $(BIN_DEST_DIR)/, $(BIN_SRCS)), unlink $(file) 2>/dev/null || true${\n})

clean: clean-config clean-data clean-bin

prog ?= $(error Please set this flag)

track-config:
	mv $(XDG_CONFIG_HOME)/$(prog) config/$(prog)
	@$(MAKE) --no-print-directory $(XDG_CONFIG_HOME)/$(prog)

.PHONY: all clean clean-config clean-data clean-bin bin config data mac track-config
