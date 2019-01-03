#!/usr/bin/env bash

# clear screen
clear

# strip the -c that vim adds to bash from arguments to this script
shift

# to use aliases and functions etc.
. ${HOME}/.bash_profile

# run the given command
eval $@
