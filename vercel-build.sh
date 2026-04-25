#!/usr/bin/env bash
set -euo pipefail

FLUTTER_DIR="$HOME/flutter"

if [ ! -d "$FLUTTER_DIR" ]; then
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"
export CI=true

flutter config --no-analytics || true
dart --disable-analytics || true

flutter --version
flutter config --enable-web
flutter doctor -v
flutter pub get
flutter precache --web
flutter build web --release --base-href /
