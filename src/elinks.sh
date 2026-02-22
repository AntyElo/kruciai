#!/usr/bin/bash
source "${KRUCIAI}/base"
SRC="${KRUCIAI}/orig/elinks"
ENV="${KRUCIAI}/envs/elinks"
DEPS=(
	libnetsurf
	quickjs
)
MESONFLAGS=(
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
show)
	case $2 in
	   deps) echo "${DEPS[*]}"
	;; src)  echo "$SRC"
	;; env)  echo "$ENV"
	esac
;; init)
	cd orig
	git clone https://github.com/rkd77/elinks.git
;; update)
	cd "$SRC"
	git pull 1>&2
	git rev-parse HEAD
;; build)
	cd "$SRC"
	rm -rf build
	meson_setup build "${ENV}" ${MESONFLAGS[*]}
	meson_compile build || exit 1
	meson install -C build || exit 2
esac
