#!/usr/bin/env bash
THIS="$ROOT/pool/dest"
DEPS=(
	elinks
)
SYSDEPS=(
	git
	wget
)
LIBDEPS=(
)
FEATURES=(
)
ALD_FLAGS=(
	--appdir "$THIS/AppDir"
	--deploy-deps-only "$THIS/AppDir/usr/bin"
	-d "$ROOT/data/kruciai.desktop"
	-i "$ROOT/data/kruciai.png"
	--custom-apprun "$ROOT/data/AppRun"
	--output appimage
)
if [ -n "$USECHAWAN" ]
then
	DEPS+=('chawan')
	FEATURES+=(USECHAWAN\=\""$USECHAWAN"\")
fi

case "$1" in
init)
	(
		wget "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-$ARCHM.AppImage"
		wget "https://github.com/linuxdeploy/linuxdeploy-plugin-appimage/releases/download/continuous/linuxdeploy-plugin-appimage-$ARCHM.AppImage"
	) 1>>"$ROOT/log/1" 2>>"$ROOT/log/2"
	chmod +x "linuxdeploy-$ARCHM.AppImage"
	chmod +x "linuxdeploy-plugin-appimage-$ARCHM.AppImage"
;; update)
	cd "$ROOT" || exit 2
	"$ROOT/base" uh0 "dest" "$( git log ORIG_HEAD.. )"
	git -C "$ROOT" rev-parse HEAD > "$ROOT/.git/ORIG_HEAD"
	printf "dest %s (git %s)" "$(date "+%Y%m%dT%H%M%S")" "$(git rev-parse HEAD)"
;; build)
	mkdir -p "$THIS/AppDir/etc"
	cp -RT "$ROOT/data/etc" "$THIS/AppDir/etc"
	export LD_LIBRARY_PATH="$THIS/AppDir/usr/lib/$ARCHT:$THIS/AppDir/usr/lib:$THIS/AppDir/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
	1>>"$ROOT/log/1" 2>>"$ROOT/log/2"\
		"$THIS/src/linuxdeploy-$ARCHM.AppImage" "${ALD_FLAGS[@]}" || exit 1
	mv kruciai* "$ROOT" # name is taken from #data/kruciai.desktop
;; esac
