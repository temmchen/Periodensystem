#!/usr/bin/env bash
# Baut aus dem Swift-Package eine eigenständige macOS-App (.app-Bundle).
set -euo pipefail

APP_NAME="Periodensystem"
BUNDLE_ID="ch.tomb.periodensystem"
DISPLAY_NAME="Periodensystem"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if ! command -v swift >/dev/null 2>&1; then
  echo "✗ Swift-Toolchain nicht gefunden. Bitte Xcode oder die Command Line Tools installieren:" >&2
  echo "    xcode-select --install" >&2
  exit 1
fi

echo "→ Release-Build mit Swift Package Manager…"
swift build -c release

BIN_PATH="$(swift build -c release --show-bin-path)"
EXEC="$BIN_PATH/$APP_NAME"

if [[ ! -x "$EXEC" ]]; then
  echo "✗ Binary nicht gefunden: $EXEC" >&2
  exit 1
fi

APP_BUNDLE="$SCRIPT_DIR/$APP_NAME.app"
echo "→ Verpacke .app-Bundle: $APP_BUNDLE"
rm -rf "$APP_BUNDLE"
mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"

cp "$EXEC" "$APP_BUNDLE/Contents/MacOS/$APP_NAME"

cat > "$APP_BUNDLE/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>      <string>de</string>
    <key>CFBundleDisplayName</key>             <string>$DISPLAY_NAME</string>
    <key>CFBundleExecutable</key>              <string>$APP_NAME</string>
    <key>CFBundleIdentifier</key>              <string>$BUNDLE_ID</string>
    <key>CFBundleInfoDictionaryVersion</key>   <string>6.0</string>
    <key>CFBundleName</key>                    <string>$APP_NAME</string>
    <key>CFBundlePackageType</key>             <string>APPL</string>
    <key>CFBundleShortVersionString</key>      <string>1.0</string>
    <key>CFBundleVersion</key>                 <string>1</string>
    <key>LSApplicationCategoryType</key>       <string>public.app-category.education</string>
    <key>LSMinimumSystemVersion</key>          <string>13.0</string>
    <key>NSHighResolutionCapable</key>         <true/>
    <key>NSPrincipalClass</key>                <string>NSApplication</string>
    <key>NSSupportsAutomaticTermination</key>  <true/>
    <key>NSSupportsSuddenTermination</key>     <true/>
</dict>
</plist>
PLIST

# Ad-hoc Code-Signing, damit Gatekeeper das lokale Build akzeptiert.
if codesign --force --deep --sign - "$APP_BUNDLE" >/dev/null 2>&1; then
  echo "→ Ad-hoc Code-Signatur angebracht."
else
  echo "→ Hinweis: Code-Signing fehlgeschlagen (für lokalen Start nicht kritisch)."
fi

echo ""
echo "✓ Fertig: $APP_BUNDLE"
echo ""
echo "  Starten:  open \"$APP_BUNDLE\""
echo "  Installieren (optional):  cp -R \"$APP_BUNDLE\" /Applications/"
