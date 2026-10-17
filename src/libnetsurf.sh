#!/usr/bin/env bash
THIS="$ROOT/pool/libnetsurf/"
DEPS=(
)
SYSDEPS=(
	wget
	make
	perl
	gperf
)
LIBDEPS=(
	libpsl
)
BS=buildsystem-1.10
SUB=(
	libparserutils-0.2.5
	libwapcaplet-0.4.3
	libhubbub-0.3.8
	libcss-0.9.2
	libdom-0.4.2
)
USEFLAGS=(
	Q\=
	LIBDIR\=lib
	COMPONENT_TYPE\=lib-static
)

helper() {
	case "$1" in
	init)\
		(
			wget "http://download.netsurf-browser.org/libs/releases/$BS.tar.gz"
			tar -xf "$BS.tar.gz"
		) 1>>"$ROOT/log/1" 2>>"$ROOT/log/2"
		rm "$BS.tar.gz"
		for i in "${SUB[@]}"
		do (
				wget "http://download.netsurf-browser.org/libs/releases/$i-src.tar.gz"
				tar -xf "$i-src.tar.gz"
			) 1>>"$ROOT/log/1" 2>>"$ROOT/log/2"
			rm "$i-src.tar.gz"
		done
	;; update)
		# some kind of manual update
		"$ROOT/base" uh0 "libnetsurf"
		echo wget "$BS" "${SUB[@]}"
	;; build)
		export CFLAGS="-Wno-error" PREFIX="$THIS/AppDir"
		1>>"$ROOT/log/1" 2>>"$ROOT/log/2" \
			make -C "$BS" install || exit 1
		for i in "${SUB[@]}"
		do 1>>"$ROOT/log/1" 2>>"$ROOT/log/2" \
			make -C "$i" install -j1 "${USEFLAGS[@]}" || exit 2
		done
		unset CFLAGS PREFIX
	;; esac
}
helper "$@"
