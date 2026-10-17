#!/usr/bin/env bash
THIS="$ROOT/pool/chawan/"
DEPS=(
)
SYSDEPS=(
	git
	make
	nim
)
LIBDEPS=(
	libbrotlicommon
	libbrotlidec
	libcrypto
	libssl
	libssh2
)

case "$1" in
init)
	"$ROOT/base" cg "https://git.sr.ht/~bptato/chawan" .
;; update)
	"$ROOT/base" ug chawan
;; build)
	export PREFIX=/usr
	mkdir -p "$THIS/AppDir"
	cd "$THIS/src" || exit 1
	1>>"$ROOT/log/1" 2>>"$ROOT/log/2" make || exit 2
	1>>"$ROOT/log/1" 2>>"$ROOT/log/2" DESTDIR="$THIS/AppDir" make install || exit 3
	unset PREFIX
;; esac
