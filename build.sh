#
#  Copyright © 2021 - present Julian Gerhards
#  GitHub https://github.com/knoggl/CleanUI
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

echo "Remove old xcframework build..."
rm -rf "./build/CleanUI.xcframework"

echo "Remove old frameworks..."
rm -rf "./build/iphoneos"
rm -rf "./build/iphonesimulator"

echo "Building for iOS..."
xcodebuild archive clean \
    -scheme CleanUI \
    -configuration Release \
    -destination 'generic/platform=iOS' \
    -archivePath "./build/iphoneos/CleanUI.xcarchive" \
    -sdk iphoneos15.0 \
    SKIP_INSTALL=NO \
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
    ONLY_ACTIVE_ARCH=NO \
    -UseModernBuildSystem=YES

echo "Building for iOS Simulator..."
    xcodebuild archive clean \
    -scheme CleanUI \
    -configuration Release \
    -destination 'generic/platform=iOS Simulator' \
    -archivePath "./build/iphonesimulator/CleanUI.xcarchive" \
    -sdk iphonesimulator15.0 \
    SKIP_INSTALL=NO \
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
    ONLY_ACTIVE_ARCH=NO \
    -UseModernBuildSystem=YES

echo "Extract the frameworks from the Archives..."
cp -r "./build/iphonesimulator/CleanUI.xcarchive/Products/Library/Frameworks/." "./build/iphonesimulator"
cp -r "./build/iphoneos/CleanUI.xcarchive/Products/Library/Frameworks/." "./build/iphoneos"

echo "Building XCFramework..."
xcodebuild -create-xcframework \
  -framework "./build/iphoneos/CleanUI.framework" \
  -framework "./build/iphonesimulator/CleanUI.framework" \
  -output "./build/CleanUI.xcframework"
