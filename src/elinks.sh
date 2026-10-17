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
	openssl
	libbrotlicommon #brotli
	libbrotlidec #brotli
	zlib
	liblzma
	libevent
	libavif
	libwebp
	librsvg-2.0
	libsixel
	libcurl
)
MESONFLAGS=(
	elinks
	-Dbuildtype\=release
	-Dapidoc\=false
	-Dxterm\=x-terminal-emulator
	-Dopenssl\=true
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

# GPM have not .pc file
if echo '#include <gpm.h>' | cc -x c - -lgpm -o /dev/null 2>/dev/null
then MESONFLAGS+=("-Dgpm=true")
else MESONFLAGS+=("-Dgpm=false")
fi

# execinfo have not .pc file
if echo '#include <execinfo.h>' | cc -x c - -lexecinfo -o /dev/null 2>/dev/null
then MESONFLAGS+=("-Dbacktrace=true")
else MESONFLAGS+=("-Dbacktrace=false")
fi

case "$1" in
init)
	"$ROOT/base" cg "https://github.com/rkd77/elinks.git" .
;; update)
	"$ROOT/base" ug elinks
;; build)
	"$ROOT/base" bm "${MESONFLAGS[@]}"
;; why-no-build)
	"$ROOT/base" wnbm elinks
esac
