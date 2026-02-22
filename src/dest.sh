#!/usr/bin/bash
SRC="${KRUCIAI}/orig/linuxdeploy"
ENV="${KRUCIAI}/AppDir"
DEPS=(
	elinks
)
ALD_FLAGS=(
	--appdir AppDir
	-e AppDir/usr/bin/elinks
	-d data/elinks.desktop
	-i data/kruciai.png
)
if [ -n "$USECHAWAN" ]
then DEPS+=('chawan')
fi
ARCHM="${ARCHM:-$(uname -m)}"

cd "${KRUCIAI}"
case $1 in
show)
	case $2 in
	   deps) echo "${DEPS[*]}"
	;; src)  echo "$SRC"
	;; env)  echo "$ENV"
	esac
;; init)
	# here we shoud make $SRC
	mkdir -p "$SRC"
	cd "$SRC"
	wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-${ARCHM}.AppImage
	wget https://github.com/linuxdeploy/linuxdeploy-plugin-appimage/releases/download/continuous/linuxdeploy-plugin-appimage-${ARCHM}.AppImage
	chmod +x linuxdeploy-${ARCHM}.AppImage
	chmod +x linuxdeploy-plugin-appimage-${ARCHM}.AppImage
;; update)
	date
;; build)
	cp -r data/etc "$ENV/etc"
	"${SRC}/linuxdeploy-${ARCHM}.AppImage" "${ALD_FLAGS[@]}" || exit 1
	rm "$ENV/AppRun"
	cp data/AppRun "$ENV/AppRun"
	"${SRC}/linuxdeploy-plugin-appimage-${ARCHM}.AppImage" --appdir AppDir || exit 2
;; esac
