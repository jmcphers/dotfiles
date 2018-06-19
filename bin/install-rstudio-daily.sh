#!/bin/bash
#
# Installs the latest RStudio daily build for OSX.

set -e

# https://support.rstudio.com/hc/en-us/articles/203842428-Getting-the-newest-RStudio-builds
REDIRECT_URL="http://www.rstudio.org/download/latest/daily/desktop/mac/RStudio-latest.dmg"
echo "Discovering daily build from: ${REDIRECT_URL}"

# Perform a HEAD request to find the redirect target. We use the name of the
# file to derive the mounted volume name.
RELEASE_URL=$(curl -s -L -I -o /dev/null -w '%{url_effective}' "${REDIRECT_URL}")
if [ "${RELEASE_URL}" ==  "" ]; then
    echo "Could not extract daily build URL from listing; maybe rstudio.org is having problems?"
    echo "Check: ${DAILY_LIST_URL}"
    exit 1
fi

echo "Downloading daily build from: ${RELEASE_URL}"

cd /tmp

TARGET=$(basename "${RELEASE_URL}")
# Volume name mirrors the DMG filename without extension.
# Simpler than parsing hdiutil output.
VOLUME_NAME=$(basename "${TARGET}" .dmg)
VOLUME_MOUNT="/Volumes/${VOLUME_NAME}"

curl -L -o "${TARGET}" "${RELEASE_URL}"

hdiutil attach -quiet "${TARGET}"

# Remove any prior installation.
rm -rf /Applications/RStudio.app
cp -R "${VOLUME_MOUNT}/RStudio.app" /Applications

hdiutil detach -quiet "${VOLUME_MOUNT}"

rm "${TARGET}"

echo "Installed ${VOLUME_NAME} to /Applications"
