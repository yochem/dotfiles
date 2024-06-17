#!/usr/bin/env bash

help() {
	cat << EOF
Usage: dot.sh [sync|track|clean] [FILE...]
       dot.sh --help

Manage dotfiles. Either sync (from this repo to your dotfile directories) or
Start tracking (from your dotfile directories to this repository) your dotfiles.

COMMANDS
	sync		Symlinks file from this repository to your dotfile directories
	track		Moves dotfile to this repository and starts sync
	clean		Removes dotfile, but only if it exists in this repository

FILES
	Files that should be synced/tracked/cleaned. Use glob patterns for easy
	syncing of many files. The * in the root directory will only match the
	dotfile directories: config, data, home, bin

EXAMPLES
	Sync all dotfiles:

	./dot.sh sync */*

	Sync all configs:

	./dot.sh sync config/*

	Sync everything for nvim:

	./dot.sh sync */nvim

	Sync or track config of newprogram:

	./dot.sh config/newprogram

	Clean all bin files:

	./dot.sh clean bin/*
EOF
	exit
}

track-file() {
	test ! -e "$2" && {
		echo "file '$2' does not exist" >&2
		return 1
	}
	test -e "$1" && {
		echo "file '$2' already tracked" >&2
		return 1
	}
	echo mv "$2" "$1" >/dev/null
	echo ln -sfv "$1" "$2"
}

track() {
	prog=(${1//\// })
	if [ ${#prog[@]} = 1 ]; then
		paths=(config/"$1" data/"$1" home/"$1" bin/"$1")
	else
		paths=("$1")
	fi
	for path in ${paths[@]}; do
		track-file "$(realpath "$path")" "$(get-target-dir "$path")"
	done
}

get-target-dir() {
	prog="$(basename "$1")"
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
	for path in $@; do
		target="$(get-target-dir "$path")"
		[ -e "$target" ] && {
			echo command ln -sfv "$(realpath "$path")" "$target"
		}
	done
}

clean() {
	for path in $@; do
		target="$(get-target-dir "$path")"
		[ -e "$target" ] && {
			echo command unlink -v "$target"
		}
	done
}

guess() {
	shopt -s globstar
	shopt -s nullglob
	files=$(echo **/"$1")
	if [ -n "$files" ]; then
		sync $files
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
	case "$command" in
		track)
			shift
			track "${@}"
			;;
		sync)
			shift
			sync "${@}"
			;;
		clean)
			shift
			clean "${@}"
			;;
		mac)
			shift
			echo TODO
			;;
		--help|-h)
			help
			;;
		*)
			# try sync, otherwise track
			guess "${@}"
			;;
	esac
}

main "${@}"
