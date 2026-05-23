#!/usr/bin/env bash
# Validates CourseMapCatalog ↔ CourseCatalog consistency via XCTest.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
DESTINATION="${DESTINATION:-platform=iOS Simulator,name=iPhone 17,OS=26.5}"
xcodebuild test \
  -scheme "Tight Rope Car" \
  -destination "$DESTINATION" \
  -only-testing:'Tight Rope CarTests/CourseMapCatalogIntegrityTests'
