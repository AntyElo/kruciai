#!/usr/bin/bash
exit 67
source "${KRUCIAI}/base"
SRC="${KRUCIAI}/orig/${name}"
ENV="${KRUCIAI}/envs/${name}"
DEPS=(
	# script.sh-s that should be installed in AppDir
	dest
)
MESONFLAGS=(
	# flags for meson (obvius)
	--help
)

cd "${KRUCIAI}" # change working dir to KRUCIAI root
case $1 in
show) shift
	case $1 in
	   deps) echo "${DEPS[*]}"  # here we shoud print all DEPS and exit
	;; src)  echo "$SRC"        # here we shoud print where source of package and exit
	;; env)  echo "$ENV"        # here we shoud print where "AppDir" of package and exit
	esac
	exit
;; init)
	# here we shoud make $SRC
	cd orig
	git clone https://github.com/${author}/${name}.git
;; update)
	# here we shoud update $SRC and return its version to main
	cd "$SRC"
	git pull # 1>&2
	git rev-parse HEAD
;; build)
	# here we shoud build $SRC, install it in $ENV
	cd "$SRC"
	rm -rf build
	meson_setup build "${ENV}" ${MESONFLAGS[*]}
	meson_compile build || return 1
	meson install -C build || return 2
;; esac
