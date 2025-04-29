#!/bin/bash

# Configuration
APP_NAME="SpellBound AI"
APP_VERSION="2.2.1"
DMG_NAME="${APP_NAME}-${APP_VERSION}.dmg"
APP_PATH="/Users/ne0r0mancer/Library/Developer/Xcode/DerivedData/SpellBoundMenuBar-brwgmsqvfvfxxlejmarobgoyilam/Build/Products/Release/${APP_NAME}.app"
DMG_PATH="build/${DMG_NAME}"

# Create build directory if it doesn't exist
mkdir -p build

# Build the app
xcodebuild -scheme SpellBoundMenuBar -configuration Release

# Create DMG
create-dmg \
  --volname "${APP_NAME}" \
  --volicon "SpellBoundMenuBar/Assets.xcassets/AppIcon.appiconset/icon_128x128.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "${APP_NAME}.app" 200 190 \
  --hide-extension "${APP_NAME}.app" \
  --app-drop-link 600 185 \
  "${DMG_PATH}" \
  "${APP_PATH}"

echo "DMG created at: ${DMG_PATH}" 