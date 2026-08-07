#!/bin/bash

# Ensure the output directory exists
mkdir -p listing/android-phone

# Check if device ID is provided, otherwise default to emulator-5554
DEVICE_ID=${1:-"emulator-5554"}

# Fix for AGP 8.11+ strictness on environment variables
unset ANDROID_PREFS_ROOT

echo "🚀 Starting automated screenshot generation on device: $DEVICE_ID..."

# Run the integration test with the driver
flutter drive \
  --driver=test_driver/screenshot_driver.dart \
  --target=integration_test/screenshot_test.dart \
  -d "$DEVICE_ID"

echo "✅ Screenshots generated in listing/android-phone/"
ls -lh listing/android-phone/
