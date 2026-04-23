#!/bin/bash

set -e

echo "🎨 Formatting Dart/Flutter code..."
dart format --fix lib/ test/ android/ ios/

echo "✅ Format complete"
echo ""
echo "🔍 Running analyzer..."
flutter analyze lib/ test/

echo ""
echo "✨ All checks passed!"
