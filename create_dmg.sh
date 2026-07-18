#!/bin/bash
set -euo pipefail

# Builds a Release .app and packages it into a DMG under ./build

APP_NAME="SpellBound AI"
APP_VERSION="2.2.3"
DMG_PATH="build/${APP_NAME}-${APP_VERSION}.dmg"
DERIVED_DATA="build/DerivedData"

mkdir -p build

xcodebuild \
  -scheme SpellBoundMenuBar \
  -configuration Release \
  -derivedDataPath "${DERIVED_DATA}" \
  build

APP_PATH="${DERIVED_DATA}/Build/Products/Release/${APP_NAME}.app"

if [ ! -d "${APP_PATH}" ]; then
  echo "Build succeeded but ${APP_PATH} was not found." >&2
  exit 1
fi

rm -f "${DMG_PATH}"
hdiutil create -srcfolder "${APP_PATH}" -ov -format UDZO "${DMG_PATH}"

echo "DMG created at: ${DMG_PATH}"
