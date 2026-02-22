#!/usr/bin/bash
source "${KRUCIAI}/base"
SRC="${KRUCIAI}/orig/chawan"
ENV="${KRUCIAI}/envs/chawan"
DEPS=(
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
	git clone https://git.sr.ht/~bptato/chawan
;; update)
	cd "$SRC"
	git pull 1>&2
	git rev-parse HEAD
;; build)
	cd "$SRC"
	export PREFIX=/usr
	mkdir -p "${ENV}"
	make || exit 1
	DESTDIR="${ENV}" make install || exit 2
	unset PREFIX
	#export AIM=cha
;; esac
