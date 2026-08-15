#!/bin/bash

# Ensure the output directory exists
mkdir -p listing/android-phone

# Check if device ID is provided, otherwise auto-detect emulators
if [ -z "$1" ]; then
  echo "🔍 No device ID provided, searching for connected emulators..."
  # Auto-detect emulators only (names containing 'emulator' or starting with '127.0.0.1')
  DEVICE_ID=$(adb devices | grep -v "List" | grep "device$" | grep -E "emulator|127.0.0.1" | awk '{$1=$1;print $1}' | head -n 1)

  if [ -z "$DEVICE_ID" ]; then
    echo "❌ Error: No running Android emulator found."
    echo "💡 Phone screenshot generation is only supported on emulators to ensure consistent framing."
    echo "💡 Please start an emulator from Android Studio Device Manager."
    exit 1
  fi
  echo "📱 Auto-detected emulator: $DEVICE_ID"
else
  DEVICE_ID=$1
  STATE=$(adb -s "$DEVICE_ID" get-state 2>/dev/null)
  if [ "$STATE" != "device" ]; then
    echo "❌ Error: Device '$DEVICE_ID' is not running or not reachable via ADB."
    exit 1
  fi
fi

# Fix for AGP 8.11+ strictness on environment variables
unset ANDROID_PREFS_ROOT

echo "🚀 Preparing emulator: $DEVICE_ID..."
adb -s "$DEVICE_ID" shell input keyevent KEYCODE_WAKEUP
adb -s "$DEVICE_ID" shell wm dismiss-keyguard

echo "🧹 Cleaning phone output directory..."
rm -rf listing/android-phone/*.png

echo "🎬 Starting automated phone screenshot generation..."

flutter drive \
  --driver=test_driver/screenshot_driver.dart \
  --target=integration_test/screenshot_test.dart \
  --dart-define=DEVICE_TYPE="phone" \
  -d "$DEVICE_ID"

if [ $? -eq 0 ]; then
  echo "✅ Phone screenshots generated successfully in listing/android-phone/"
  ls -lh listing/android-phone/
else
  echo "❌ Error: Phone screenshot generation failed!"
  exit 1
fi
