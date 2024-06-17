#!/usr/bin/env bash

xdg_config="$XDG_CONFIG_HOME"
xdg_data="$XDG_DATA_HOME"
dotfiles="$(dirname "$(realpath "$0")")"

help() {
	cat << EOF
Usage: dot.sh track-[config|data|home] FILE
       dot.sh sync-[config|data|home] FILE
       dot.sh FILE
       dot.sh --help

Manage dotfiles. Either sync (from this repo to your dotfile directories) or
Start tracking (from your dotfile directories to this repository) your dotfiles.

You can specify the action you want using track-* and sync-* commands. If not
provided, sync is tried first and otherwise track.
EOF
	exit
}

track-file() {
	test "$2" = "$xdg_config" -o "$2" = "$xdg_data" -o "$2" = "$HOME" && {
		echo "no file provided"
		return 1
	}
	test ! -e "$2" && {
		echo "file '$2' does not exist"
		return 1
	}
	test -e "$1" && {
		echo "file '$2' already tracked"
		return 1
	}
	echo "starting tracking $(basename "$(dirname "$1")") for $(basename "$1")"
	mv -v "$2" "$1" >/dev/null
	ln -sfv "$1" "$2"
}

track() {
	if [ -z "$2" ] || [ "$2" = "config" ]; then
		track-file "$dotfiles/config/$1" "$xdg_config/$1"
	fi
	if [ -z "$2" ] || [ "$2" = "data" ]; then
		track-file "$dotfiles/data/$1" "$xdg_data/$1"
	fi
	if [ -z "$2" ] || [ "$2" = "home" ]; then
		track-file "$dotfiles/home/$1" "$HOME/.$1"
	fi
}

sync-file() {
	test "$2" = "$xdg_config" -o "$2" = "$xdg_data" -o "$2" = "$HOME" && {
		echo "no file provided"
		return 1
	}
	test ! -e "$1" && {
		echo "file '$2' does not exist"
		return 1
	}
	test -e "$2" && {
		echo "file '$2' already synced"
		return 1
	}
	echo "starting syncing $(basename "$(dirname "$1")") for $(basename "$1")"
	ln -sfv "$1" "$2"
}

sync() {
	if [ -z "$2" ] || [ "$2" = "config" ]; then
		sync-file "$dotfiles/config/$1" "$xdg_config/$1"
	fi
	if [ -z "$2" ] || [ "$2" = "data" ]; then
		sync-file "$dotfiles/data/$1" "$xdg_data/$1"
	fi
	if [ -z "$2" ] || [ "$2" = "home" ]; then
		sync-file "$dotfiles/home/$1" "$HOME/.$1"
	fi
}

guess() {
	shopt -s nullglob
	file="$(echo */$1)"
	if [ -n "$file" ]; then
		# check which one was matching and don't run rest
		[ -e "$dotfiles/config/$1" ] && sync "$1" "config"
		[ -e "$dotfiles/data/$1" ] && sync "$1" "data"
		[ -e "$dotfiles/home/$1" ] && sync "$1" "home"
	else
		# try to track everything
		track "$1"
	fi
}

main() {
	[ $# -eq 0 ] || [ "${@: -1}" = "--help" ] && help

	echo "${XDG_CONFIG_HOME?unset or null (export XDG_DATA_HOME=$HOME/.config)}" >/dev/null
	echo "${XDG_DATA_HOME?unset or null (export XDG_DATA_HOME=$HOME/.local/share)}" >/dev/null

	command="$1"
	case "$command" in 
		track|track-config|track-data|track-home)
			# strip `track-` part
			dir=${command:6}
			track "$2" "$dir"
			;;
		sync|sync-config|sync-data|sync-home)
			# strip `sync-` part
			dir=${command:6}
			sync "$2" "$dir"
			;;
		mac)
			echo TODO
			;;
		--help|-h)
			help
			;;
		*)
			guess "$1"
			;;
	esac
}

main "${@}"
