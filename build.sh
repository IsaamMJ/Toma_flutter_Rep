#!/bin/bash
set -e  # Exit on any error

echo "Installing Flutter..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:`pwd`/flutter/bin"

echo "Flutter version:"
flutter --version

echo "Enabling web support..."
flutter config --enable-web

echo "Getting dependencies..."
flutter pub get

echo "Building web app..."
flutter build web --release

echo "Build completed successfully!"
ls -la build/web/