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
	@[ -e config/$@ ] && $(MAKE) $(XDG_CONFIG_HOME)/$@ || true
	@[ -e data/$@ ] && $(MAKE) $(XDG_DATA_HOME)/$@ || true
	@[ -e bin/$@ ] && $(MAKE) $(BIN_DEST_DIR)/$@ || true

MADE_FILES := $(addprefix $(XDG_CONFIG_HOME)/, $(CONFIG_SRCS)) \
	$(addprefix $(XDG_DATA_HOME)/, $(DATA_SRCS)) \
	$(addprefix $(BIN_DEST_DIR)/, $(BIN_SRCS))

clean:
	-$(foreach file,$(MADE_FILES), unlink $(file) 2>/dev/null || true${\n})

.PHONY: all clean bin config data mac
