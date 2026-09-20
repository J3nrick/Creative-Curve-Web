#!/usr/bin/env bash
# ==============================================================================
# Creative Curve Studios - Vercel Production Build Script
# Automatically provisions Flutter SDK (stable), enables Web support,
# downloads dependencies, and compiles optimized release Web bundle.
# ==============================================================================

set -euo pipefail

echo "==> [Creative Curve CI/CD] Starting Vercel Web Build..."

FLUTTER_DIR="$HOME/flutter"

# 1. Clone Flutter Stable channel if not already cached
if [ ! -d "$FLUTTER_DIR" ]; then
  echo "==> [Flutter SDK] Cloning Flutter SDK (stable channel)..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$FLUTTER_DIR"
else
  echo "==> [Flutter SDK] Flutter SDK found in cache: $FLUTTER_DIR"
fi

# 2. Set PATH to Flutter binaries
export PATH="$FLUTTER_DIR/bin:$PATH"

# 3. Configure Flutter environment
echo "==> [Flutter SDK] Configuring Web support..."
flutter config --no-analytics
flutter config --enable-web

# 4. Diagnostics
echo "==> [Flutter Diagnostics] Flutter Doctor..."
flutter doctor -v

# 5. Fetch dependencies
echo "==> [Dependencies] Resolving pub packages..."
flutter pub get

# 6. Execute Production Web Release Build
echo "==> [Build] Compiling Flutter Web release bundle..."
flutter build web --release --base-href /

echo "==> [Creative Curve CI/CD] Build completed successfully. Output ready in build/web."