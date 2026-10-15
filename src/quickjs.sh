#!/usr/bin/env bash
DEPS=(
)
SYSDEPS=(
	git
	meson
	ninja
	cmake
	pkg-config
)
LIBDEPS=(
)
MESONFLAGS=(
	quickjs
	-Dbuildtype\=release
	-Ddebug\=false
)

helper() {
	case "$1" in
	init)
		"$ROOT/base" cg "https://github.com/quickjs-ng/quickjs.git" .
	;; update)
		"$ROOT/base" ug quickjs
		exit $?
	;; build)
		"$ROOT/base" bm "${MESONFLAGS[@]}"
		exit $?
	;; esac
}
helper "$@"
