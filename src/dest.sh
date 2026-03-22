#!/usr/bin/bash
THIS="${ROOT}/pool/dest"
DEPS=(
	elinks
)
ALD_FLAGS=(
	--appdir "${THIS}/AppDir"
	--deploy-deps-only "${THIS}/AppDir/usr/bin"
	-d "${ROOT}/data/elinks.desktop"
	-i "${ROOT}/data/kruciai.png"
	--custom-apprun "${ROOT}/data/AppRun"
	--output appimage
)
if [ -n "$USECHAWAN" ]
then
	DEPS+=('chawan')
fi

case $1 in
deps)
	echo "${DEPS[*]}"
	exit
;; init)
	wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-${ARCHM}.AppImage
	wget https://github.com/linuxdeploy/linuxdeploy-plugin-appimage/releases/download/continuous/linuxdeploy-plugin-appimage-${ARCHM}.AppImage
	chmod +x linuxdeploy-${ARCHM}.AppImage
	chmod +x linuxdeploy-plugin-appimage-${ARCHM}.AppImage
;; update)
	cd ${ROOT}
	update-hook0 "dest"
	CHANGES="$( git log ORIG_HEAD.. )"
	mkdir -p "${ROOT}/pool/dest/AppDir/etc/pkgup/changes/"
	if [ -n "${CHANGES}" ]
	then echo "${CHANGES}" > "${ROOT}/pool/dest/AppDir/etc/pkgup/changes/dest"
	fi
	unset CHANGES
	echo -n "git "
	git rev-parse HEAD
	echo -n " at "
	date
;; build)
	mkdir -p "${THIS}/AppDir/etc"
	cp -RT "${ROOT}/data/etc" "${THIS}/AppDir/etc"
	export LD_LIBRARY_PATH="${THIS}/AppDir/usr/lib/${ARCHT}:${THIS}/AppDir/usr/lib:${THIS}/AppDir/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
	"${THIS}/src/linuxdeploy-${ARCHM}.AppImage" "${ALD_FLAGS[@]}" || exit 1
	mv ELinks* "${ROOT}" # I guess "ELinks" is taken from ${ROOT}/data/elinks.desktop
#;; BREAK) echo BUILD
;; esac
