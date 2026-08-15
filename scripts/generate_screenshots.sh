#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

DEVICE_ID=$1

echo "🚀 Starting full screenshot generation process..."

# 1. Generate Phone Screenshots
echo "📱 Phase 1: Generating Phone Screenshots..."
"$SCRIPT_DIR/generate_phone_screenshots.sh" "$DEVICE_ID"
if [ $? -ne 0 ]; then
  echo "❌ Error: Phone screenshot generation failed. Aborting."
  exit 1
fi

echo ""

# 2. Generate Tablet Screenshots
echo "💻 Phase 2: Generating Tablet Screenshots..."
"$SCRIPT_DIR/generate_tablet_screenshots.sh" "$DEVICE_ID"
if [ $? -ne 0 ]; then
  echo "❌ Error: Tablet screenshot generation failed. Aborting."
  exit 1
fi

echo ""
echo "✨ Full screenshot generation complete!"
echo "📁 Phone: listing/android-phone/"
echo "📁 Tablet: listing/android-tablet/"
