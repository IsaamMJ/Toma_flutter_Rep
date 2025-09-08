#!/bin/bash
# Exit on error
set -e

# Install Flutter SDK
echo "Downloading Flutter SDK..."
git clone https://github.com/flutter/flutter.git /opt/buildhome/flutter
export PATH="/opt/buildhome/flutter/bin:$PATH"

# Enable Flutter web
flutter channel stable
flutter upgrade
flutter config --enable-web

# Check Flutter version
flutter --version
