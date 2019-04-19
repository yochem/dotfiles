#!/usr/bin/env bash

# clear screen
clear

. "$HOME/.bash_profile"

# strip the -c that vim adds to bash from arguments to this script
shift

# run the given command
eval $@
