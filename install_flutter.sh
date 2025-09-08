#!/bin/bash
set -e  # Stop on error

echo "Installing Flutter SDK..."

# Do NOT remove system paths, just add Flutter path
export PATH="$PATH:/opt/buildhome/flutter/bin:/opt/buildhome/.pub-cache/bin"

# Install Flutter
git clone https://github.com/flutter/flutter.git /opt/buildhome/flutter

# Enable Flutter Web
flutter channel stable
flutter upgrade
flutter config --enable-web

# Verify installation
flutter --version
