#!/bin/zsh
set -eu
cd "$(dirname "$0")"
./build.sh
APP="dist/Tangdou.app"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
cp DesktopFly "$APP/Contents/MacOS/Tangdou"
cp -R data "$APP/Contents/Resources/"
cp LICENSE README.md UPSTREAM.md "$APP/Contents/Resources/"
cat > "$APP/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleName</key><string>Tangdou</string>
<key>CFBundleDisplayName</key><string>糖豆 Tangdou</string>
<key>CFBundleIdentifier</key><string>io.github.syydaniel.tangdou</string>
<key>CFBundleExecutable</key><string>Tangdou</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>0.1.0</string>
<key>CFBundleVersion</key><string>1</string>
<key>LSMinimumSystemVersion</key><string>13.0</string>
<key>LSUIElement</key><true/>
<key>NSHighResolutionCapable</key><true/>
</dict></plist>
PLIST
codesign --force --deep --sign - "$APP"
echo "Built $APP (local ad-hoc signature; not notarized)"
