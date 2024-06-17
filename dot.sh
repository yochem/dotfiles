#!/usr/bin/env bash

help() {
	cat << EOF
Usage: dot.sh [sync|track|clean] [FILE]
       dot.sh --help

Manage dotfiles. Either sync (from this repo to your dotfile directories) or
Start tracking (from your dotfile directories to this repository) your dotfiles.

sync	Symlinks file from this repository to your dotfile directories
track	Moves dotfile to this repository and starts sync
clean	Removes dotfile, but only if it exists in this repository

FILE can be either
	- config/data/home/bin: Run command for all files in that directory
	- Single filename: Try to run the command for every directory listed above
	- Empty: Run command on all (does not work with track)
EOF
	exit
}

track-file() {
	test ! -e "$2" && {
		echo "file '$2' does not exist"
		return 1
	}
	test -e "$1" && {
		echo "file '$2' already tracked"
		return 1
	}
	echo mv "$2" "$1" >/dev/null
	echo ln -sfv "$1" "$2"
}

track() {
	local prog=(${1//\// })
	if [ ${#prog[@]} = 1 ]; then
		paths=(config/"$1" data/"$1" home/"$1" bin/"$1")
	else
		paths=("$1")
	fi
	for path in "${paths[@]}"; do
		track-file "$(realpath "$path")" "$(get-target-dir "$path")"
	done
}

find-files() {
	echo $(echo {config,data,home,bin}/* | tr ' ' '\n' | grep "$1")
}

get-target-dir() {
	local prog="$(basename "$1")"
	case "$1" in
		config/*)
			echo "$XDG_CONFIG_HOME/$prog"
			;;
		data/*)
			echo "$XDG_DATA_HOME/$prog"
			;;
		home/*)
			echo "$HOME/.$prog"
			;;
		bin/*)
			echo "$BIN/$prog"
			;;
	esac
}

sync() {
	result=$(find-files "$1")
	for path in $result; do
		target="$(get-target-dir "$path")"
		echo command ln -sfv "$(realpath "$path")" "$target"
	done
}

clean() {
	result=$(find-files "$1")
	for path in $result; do
		target="$(get-target-dir "$path")"
		echo command unlink -v "$target"
	done
}

guess() {
	files="$(find-files "$1")"
	if [ -n "$files" ]; then
		sync "$1"
	else
		track "$1"
	fi
}

main() {
	[ $# -eq 0 ] || [ "${@: -1}" = "--help" ] && help

	echo "${XDG_CONFIG_HOME?unset or null (export XDG_DATA_HOME=$HOME/.config)}" >/dev/null
	echo "${XDG_DATA_HOME?unset or null (export XDG_DATA_HOME=$HOME/.local/share)}" >/dev/null
	echo "${BIN?unset or null (export BIN=$HOME/.local/bin)}" >/dev/null

	command="$1"
	shift
	case "$command" in
		track)
			track $@
			;;
		sync)
			sync $@
			;;
		clean)
			clean $@
			;;
		mac)
			echo TODO
			;;
		--help|-h)
			help
			;;
		*)
			# try sync, otherwise track
			guess "$1"
			;;
	esac
}

main "${@}"
