#!/usr/bin/bash
source "${KRUCIAI}/base"
SRC="${KRUCIAI}/pool/quickjs/src"
ENV="${KRUCIAI}/pool/quickjs/AppDir"
DEPS=(
)
MESONFLAGS=(
	quickjs
	-Dbuildtype\=release
	-Ddebug\=false
)

case $1 in
deps)
	echo "${DEPS[*]}"
	exit
;; init)
	git clone https://github.com/quickjs-ng/quickjs.git .
;; update)
	update-git quickjs
;; build)
	build-meson ${MESONFLAGS[*]}
;; esac
