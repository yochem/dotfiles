# ifndef XDG_CONFIG_HOME
# $(error XDG_CONFIG_HOME is undefined)
# endif
#
# ifndef XDG_DATA_HOME
# $(error  XDG_DATA_HOME is undefined) is undefined)
# endif

.DEFAULT_GOAL := donothing
donothing:
	@true

target_config := test/config
target_data := test/data
target_bin ?= test/bin
target_home ?= test/home
TARGET_DIRS := $(target_config) $(target_data) $(target_bin) $(target_home)

$(TARGET_DIRS):
	mkdir -p $@

$(target_config)/%: config/% | $(target_config)
	ln -s $(abspath $<) $(target_config)

$(target_data)/%: data/% | $(target_data)
	ln -s $(abspath $<) $(target_data)

$(target_home)/%: home/% | $(target_home)
	ln -s $(abspath $<) $(target_home)
	mv $@ $(HOME)/.$(notdir $@)

$(target_bin)/%: bin/% | $(target_bin)
	ln -s $(abspath $<) $(target_bin)

# only removes files that are a symlink to this directory
clean: | $(TARGET_DIRS)
	find $| -type l -lname '$(shell pwd)*' -exec rm -v {} +

.PHONY: clean

# hack: make without argument does nothing due to 'donothing' target
%:
	@$(MAKE) $(addprefix $(target_config)/,$(notdir $(wildcard config/$@)))
	@$(MAKE) $(addprefix $(target_data)/,$(notdir $(wildcard data/$@)))
	@$(MAKE) $(addprefix $(target_bin)/,$(notdir $(wildcard bin/$@)))
	@$(MAKE) $(addprefix $(target_home)/,$(notdir $(wildcard home/$@)))

all:
	@$(MAKE) $(addprefix $(target_config)/,$(notdir $(wildcard config/*)))
	@$(MAKE) $(addprefix $(target_data)/,$(notdir $(wildcard data/*)))
	@$(MAKE) $(addprefix $(target_bin)/,$(notdir $(wildcard bin/*)))
	@$(MAKE) $(addprefix $(target_home)/,$(notdir $(wildcard home/*)))

.PHONY: all
