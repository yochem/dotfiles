# ifndef XDG_CONFIG_HOME
# $(error XDG_CONFIG_HOME is undefined)
# endif
#
# ifndef XDG_DATA_HOME
# $(error  XDG_DATA_HOME is undefined) is undefined)
# endif

# local_config_dir := $(XDG_CONFIG_HOME)
# local_data_dir := $(XDG_DATA_HOME)
# local_bin_dir ?= $(HOME)/.local/bin
# local_home_dir ?= $(HOME)

local_config_dir := test/config
local_data_dir := test/data
local_bin_dir := test/bin
local_home_dir := test/home

REPO_DIRS := config data bin home

# Program-specific
# $(local_config_dir)/%: config/% | $(local_config_dir)
# 	ln -i -s $(abspath $<) $(abspath $(dir $@))
#
# $(local_data_dir)/%: data/% | $(local_data_dir)
# 	ln -s $(abspath $<) $(abspath $(dir $@))
#
# $(local_home_dir)/%: home/% | $(local_home_dir)
# 	ln -s $(abspath $<) $(abspath $(dir $@))
#
# $(local_bin_dir)/%: bin/% | $(local_bin_dir)
# 	ln -s $(abspath $<) $(abspath $(dir $@))


# Whole source dir: config|data|bin|home
config_dirs := $(notdir $(wildcard config/*))
config_targets := $(addprefix $(local_config_dir)/,$(config_dirs))
config: $(config_targets)

data_dirs := $(notdir $(wildcard data/*))
data_targets := $(addprefix $(local_data_dir)/,$(data_dirs))
data: $(data_targets)

bin_files := $(notdir $(wildcard bin/*))
bin_targets := $(addprefix $(local_bin_dir)/,$(bin_files))
bin: $(bin_targets)

home_files := $(notdir $(wildcard home/*))
home_targets := $(addprefix $(local_home_dir)/,$(home_files))
home: $(home_targets)

all: $(REPO_DIRS)

.PHONY: all $(REPO_DIRS)

DOTS := $(config_targets) $(data_targets) $(home_targets) $(bin_targets)
$(filter %/nvim, $(DOTS)):
	echo $*

# Remove program files from system
clean-config:
	find $(local_config_dir) -type l -lname '$(shell pwd)*' -exec rm -v {} +

# TODO: individual cleans?

.PHONY: clean
