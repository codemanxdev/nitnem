#!/bin/bash

# Ensure the output directory exists
mkdir -p listing/android-phone

# Check if device ID is provided, otherwise auto-detect
if [ -z "$1" ]; then
  echo "🔍 No device ID provided, searching for connected devices..."
  DEVICE_ID=$(adb devices | grep -v "List" | grep "device$" | awk '{print $1}' | head -n 1)
  if [ -z "$DEVICE_ID" ]; then
    echo "❌ Error: No device or emulator found. Please connect one or provide a device ID."
    exit 1
  fi
  echo "📱 Auto-detected device: $DEVICE_ID"
else
  DEVICE_ID=$1
fi

# Fix for AGP 8.11+ strictness on environment variables
unset ANDROID_PREFS_ROOT

echo "🚀 Preparing device: $DEVICE_ID..."
adb -s "$DEVICE_ID" shell input keyevent KEYCODE_WAKEUP
adb -s "$DEVICE_ID" shell wm dismiss-keyguard

echo "🧹 Cleaning output directory..."
rm -rf listing/android-phone/*.png

echo "🎬 Starting automated screenshot generation..."

# Run the integration test with the driver
flutter drive \
  --driver=test_driver/screenshot_driver.dart \
  --target=integration_test/screenshot_test.dart \
  -d "$DEVICE_ID"

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
  echo "✅ Screenshots generated successfully in listing/android-phone/"
  ls -lh listing/android-phone/
else
  echo "❌ Error: Screenshot generation failed!"
  exit $EXIT_CODE
fi
