#!/bin/bash

set -e

echo "🎨 Formatting Dart/Flutter code..."
dart format --fix .

echo "✅ Format complete"
echo ""
echo "🔍 Running analyzer..."
flutter analyze

echo ""
echo "✨ All checks passed!"
