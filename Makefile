# ifndef XDG_CONFIG_HOME
# $(error XDG_CONFIG_HOME is undefined)
# endif
#
# ifndef XDG_DATA_HOME
# $(error  XDG_DATA_HOME is undefined) is undefined)
# endif

local_config_dir := $(XDG_CONFIG_HOME)
local_data_dir := $(XDG_DATA_HOME)
local_bin_dir ?= $(HOME)/.local/bin
local_home_dir ?= $(HOME)

REPO_DIRS := config data bin home

# Program-specific

$(local_data_dir)/%: data/% | $(local_data_dir)
	ln -s $(abspath $<) $(abspath $(local_data_dir))

$(local_home_dir)/%: home/% | $(local_home_dir)
	ln -s $(abspath $<) $(abspath $@)
	mv $(local_home_dir)/$* $(local_home_dir)/.$*

$(local_bin_dir)/%: bin/% | $(local_bin_dir)
	ln -s $(abspath $<) $(abspath $@)

# Whole source dir: config|data|bin|home
config_dirs := $(notdir $(wildcard config/*))
config_targets := $(addprefix $(local_config_dir)/,$(config_dirs))
config: $(config_targets)
$(config_targets): $(local_config_dir)/%: | $(local_config_dir)
	echo ln -s $(abspath $<) $(abspath $(local_config_dir))

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

# Move program to repo for tracking
config/%:
	test -e $(local_config_dir)/$* && command mv $(local_config_dir)/$* $@

data/%:
	test -e $(local_data_dir)/$* && command mv $(local_data_dir)/$* $@

bin/%:
	test -e $(local_bin_dir)/$* && command mv $(local_bin_dir)/$* $@

home/%:
	test -e $(local_home_dir)/$* && command mv $(local_home_dir)/$* $@


# This errors if prog is not given
%/error:
	$(error please provide a program name with prog=)

prog ?= error

# Start tracking program
track-config: config/$(prog) $(local_config_dir)/$(prog)
track-data: data/$(prog) $(local_data_dir)/$(prog)
track-bin: bin/$(prog) $(local_bin_dir)/$(prog)
track-home: home/$(prog) $(local_home_dir)/$(prog)

.PHONY: track-$(REPO_DIRS)

use-config: $(local_config_dir)/$(prog)
use-data: $(local_data_dir)/$(prog)
use-bin: $(local_bin_dir)/$(prog)
use-home: $(local_home_dir)/$(prog)

.PHONY: use-$(REPO_DIRS)

# Remove program files from system
clean:
	@echo rm -f $(addprefix $(local_config_dir)/, $(notdir $(wildcard config/*)))
	@echo rm -f $(addprefix $(local_data_dir)/, $(notdir $(wildcard data/*)))
	@echo rm -f $(addprefix $(local_bin_dir)/, $(notdir $(wildcard bin/*)))
	@echo rm -f $(addprefix $(local_home_dir)/, $(notdir $(wildcard home/*)))

# TODO: individual cleans?

.PHONY: clean
