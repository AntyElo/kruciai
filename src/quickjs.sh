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

case "$1" in
init)
	"$ROOT/base" cg "https://github.com/quickjs-ng/quickjs.git" .
;; update)
	"$ROOT/base" ug quickjs
;; build)
	"$ROOT/base" bm "${MESONFLAGS[@]}"
	mandir="$ROOT/pool/quickjs/AppDir/usr/share/man/man1"
	mkdir -p "$mandir"
	cp "$ROOT/pool/quickjs/src/qjs.man"  "${mandir}/qjs.1"
	cp "$ROOT/pool/quickjs/src/qjsc.man" "${mandir}/qjsc.1"
;; why-no-build)
	"$ROOT/base" wnbm quickjs
;; esac
