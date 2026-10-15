#!/usr/bin/env bash
THIS="$ROOT/pool/chawan/"
DEPS=(
)
SYSDEPS=(
	git
	make
)
LIBDEPS=(
)

helper() {
	case "$1" in
	init)
		"$ROOT/base" cg "https://git.sr.ht/~bptato/chawan" .
	;; update)
		"$ROOT/base" ug chawan
		exit $?
	;; build)
		export PREFIX=/usr
		mkdir -p "$THIS/AppDir"
		cd "$THIS/src" || exit 1
		make || exit 2
		DESTDIR="$THIS/AppDir" make install || exit 3
		unset PREFIX
	;; esac
}
helper "$@"
