#!/bin/bash
set -e

echo "Installing Flutter SDK..."
git clone https://github.com/flutter/flutter.git /opt/buildhome/flutter
export PATH="/opt/buildhome/flutter/bin:$PATH"

flutter channel stable
flutter upgrade
flutter config --enable-web

flutter --version
