#!/usr/bin/bash
source "${KRUCIAI}/base"
SRC="${KRUCIAI}/pool/elinks/src"
ENV="${KRUCIAI}/pool/elinks/AppDir"
DEPS=(
	libnetsurf
	quickjs
)
MESONFLAGS=(
	elinks
	-Dbuildtype\=release
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
	-Dlibwebp\=true
	-Dpython\=true
	-Dlibavif\=true
	-Dlibwebp\=true
	-Dsmb\=true
	 -Dstatic\=false
)

case $1 in
deps)
	echo "${DEPS[*]}"
	exit
;; init)
	git clone https://github.com/rkd77/elinks.git .
;; update)
	update-git elinks
;; build)
	build-meson ${MESONFLAGS[*]}
esac
