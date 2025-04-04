#!/usr/bin/env bash

# Stop on error
set -e
set -x

# Build jar
./gradlew build --parallel -x test
rm -rf build/libs/aqua-nightly.jar
rm -rf build/libs/*-plain.jar
cp build/libs/*.jar "build/libs/aqua-nightly.jar"

echo "Creating release package"
PACK="build/release"
rm -rf "$PACK"
mkdir -p "$PACK"
cp build/libs/aqua-nightly.jar "$PACK/aqua.jar"
cp -r config "$PACK/config"
mkdir -p "$PACK/data"

echo "Compressing"
cd build/release
zip -r ../aqua-nightly.zip .