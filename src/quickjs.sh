#!/usr/bin/bash
source "${KRUCIAI}/base"
SRC="${KRUCIAI}/orig/quickjs"
ENV="${KRUCIAI}/envs/quickjs"
DEPS=(
)
MESONFLAGS=(
	-Dbuildtype\=release
	-Ddebug\=false
)

case $1 in
show) shift
	case $1 in
	   deps) echo "${DEPS[*]}"
	;; src)  echo "$SRC"
	;; env)  echo "$ENV"
	esac
	exit
;; init)
	cd orig
	git clone https://github.com/quickjs-ng/quickjs.git
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
;; esac
