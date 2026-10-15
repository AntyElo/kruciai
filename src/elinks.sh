#!/usr/bin/env bash
DEPS=(
	libnetsurf
	quickjs
)
SYSDEPS=(
	git
	meson
	ninja
	cmake
	pkg-config
)
LIBDEPS=(
	tre
	expat
	gnutls
	libbrotlidec
	zlib
	liblzma
	libevent
	libavif
	libwebp
	librsvg-2.0
	libsixel
)
MESONFLAGS=(
	elinks
	-Dbuildtype\=release
	-Dapidoc\=false
	-Dxterm\=x-terminal-emulator
	-Dgnutls\=true
	-Dterminfo\=true
	-Dbrotli\=true
	-Dlzma\=true
	-Dlibevent\=true
	-Dlibsixel\=true
	-Dkitty\=true
	-Dlibcss\=true
	-Dquickjs\=true
	-D88-colors\=true
	-D256-colors\=true
	-Dtrue-color\=true
	-Dhtml-highlight\=true
	-Dbittorrent\=true
	-Dgemini\=true
	-Dgopher\=true
	-Dspartan\=true
	-Dnntp\=true
	-Dcgi\=true
	-Dfinger\=true
	-Dfsp\=true
	# -Dluapkg\=...
	-Dlibavif\=true
	-Dlibwebp\=true
	-Dlibrsvg\=true
	-Dsmb\=true
	-Dstatic\=false # linuxdeploy do this work
)
helper() {
	case "$1" in
	init)
		"$ROOT/base" cg "https://github.com/rkd77/elinks.git" .
	;; update)
		"$ROOT/base" ug elinks
		exit $?
	;; build)
		"$ROOT/base" bm "${MESONFLAGS[@]}"
		exit $?
	;; why-no-build)
		"$ROOT/base" wnbm "${MESONFLAGS[0]}"
	esac
}
helper "$@"
