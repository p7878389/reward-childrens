#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [ ! -f "pubspec.release.yaml" ]; then
  echo "未找到 pubspec.release.yaml"
  exit 1
fi

if [ ! -f "pubspec.yaml" ]; then
  echo "未找到 pubspec.yaml"
  exit 1
fi

cp "pubspec.yaml" "pubspec.yaml.bak"
trap 'mv "pubspec.yaml.bak" "pubspec.yaml"' EXIT

cp "pubspec.release.yaml" "pubspec.yaml"

flutter build appbundle --release --flavor prod
