#!/usr/bin/bash
source "${KRUCIAI}/base"
SRC="${KRUCIAI}/pool/chawan/src"
ENV="${KRUCIAI}/pool/chawan/AppDir"
DEPS=(
)

case $1 in
deps)
	echo "${DEPS[*]}"
	exit
;; init)
	git clone https://git.sr.ht/~bptato/chawan .
;; update)
	update-git chawan
;; build)
	cd "${SRC}"
	export PREFIX=/usr
	mkdir -p "${ENV}"
	make || exit 1
	DESTDIR="${ENV}" make install || exit 2
	unset PREFIX
	#export AIM=cha
;; esac
