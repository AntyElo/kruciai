#!/usr/bin/bash
SRC="${KRUCIAI}/orig/linuxdeploy"
ENV="${KRUCIAI}/AppDir"
DEPS=(
	elinks
)
ALD_FLAGS=(
	--appdir "${ENV}"
	--deploy-deps-only "${ENV}/usr/bin"
	-d "${KRUCIAI}/data/elinks.desktop"
	-i "${KRUCIAI}/data/kruciai.png"
	--custom-apprun "${KRUCIAI}/data/AppRun"
	--output appimage
)
if [ -n "$USECHAWAN" ]
then
	DEPS+=('chawan')
fi

cd "${KRUCIAI}"
case $1 in
show)
	case $2 in
	   deps) echo "${DEPS[*]}"
	;; src)  echo "$SRC"
	;; env)  echo "$ENV"
	esac
;; init)
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
	export LD_LIBRARY_PATH="${ENV}/usr/lib/${ARCHT}:${ENV}/usr/lib:${ENV}/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
	"${SRC}/linuxdeploy-${ARCHM}.AppImage" "${ALD_FLAGS[@]}" || exit 1
#;; NOBUILD) echo YES
;; esac
