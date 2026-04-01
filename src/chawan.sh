#!/usr/bin/env bash
source "${ROOT}/base"
THIS="${ROOT}/pool/chawan/"
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
	export PREFIX=/usr
	mkdir -p "${THIS}/AppDir"
	make || exit 1
	DESTDIR="${THIS}/AppDir" make install || exit 2
	unset PREFIX
;; esac
