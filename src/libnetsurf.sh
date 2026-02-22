#!/usr/bin/bash
source "${KRUCIAI}/base"
SRC="${KRUCIAI}/orig/libnetsurf"
ENV="${KRUCIAI}/envs/libnetsurf"
#DEPS=()
BS=buildsystem-1.10
SUB=(
	libparserutils-0.2.5
	libwapcaplet-0.4.3
	libhubbub-0.3.8
	libcss-0.9.2
	libdom-0.4.2
)

cd "${KRUCIAI}" # change working dir to KRUCIAI root
case $1 in
show) shift
	case $1 in
	   src)  echo "$SRC"
	;; env)  echo "$ENV"
	;; deps) echo "${DEPS[*]}"
	esac
	exit
;; init)
	# here we shoud make $SRC
	mkdir -p "$SRC"
	cd "$SRC"
	wget http://download.netsurf-browser.org/libs/releases/$BS.tar.gz
	tar -xf $BS.tar.gz
	rm $BS.tar.gz
	for i in "${SUB[@]}"
	do 
		wget http://download.netsurf-browser.org/libs/releases/$i-src.tar.gz
		tar -xf $i-src.tar.gz
		rm $i-src.tar.gz
	done
;; update)
	# some kind of manual update
	echo "${SUB[@]}"
;; build)
	cd "$SRC"
	export CFLAGS="-Wno-error" PREFIX="$ENV"
	make -C $BS install || return 1
	for i in "${SUB[@]}"
	do make -C $i install -j1 Q= LIBDIR=lib COMPONENT_TYPE=lib-static || exit 2
	done
	unset CFLAGS PREFIX
;; esac

