#!/usr/bin/env bash
set -euo pipefail

FLUTTER_DIR="$HOME/flutter"

# 1. Clone Flutter if not exists
if [ ! -d "$FLUTTER_DIR" ]; then
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

# 2. Enable Web and get dependencies
flutter config --enable-web
flutter pub get

# 3. Force-create web files in case they are missing in the repo
flutter create . --platforms web

# 4. Build
flutter build web --release --base-href /