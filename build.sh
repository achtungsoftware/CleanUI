echo "Remove old xcframework build..."
rm -rf "./build/CleanUI.xcframework"

echo "Remove old frameworks..."
rm -rf "./build/iphoneos"
rm -rf "./build/iphonesimulator"

echo "Building for iOS..."
xcodebuild archive \
  -scheme "CleanUI" \
  -configuration Release \
  -destination 'generic/platform=iOS' \
  -archivePath "./build/iphoneos/CleanUI.xcarchive" \
  -sdk iphoneos \
  SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

echo "Building for iOS Simulator..."
xcodebuild archive \
  -scheme "CleanUI" \
  -configuration Release \
  -destination 'generic/platform=iOS Simulator' \
  -archivePath "./build/iphonesimulator/CleanUI.xcarchive" \
  -sdk iphonesimulator \
  SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

echo "Extract the frameworks from the Archives..."
cp -r "./build/iphonesimulator/CleanUI.xcarchive/Products/Library/Frameworks/." "./build/iphonesimulator"
cp -r "./build/iphoneos/CleanUI.xcarchive/Products/Library/Frameworks/." "./build/iphoneos"

echo "Building XCFramework..."
xcodebuild -create-xcframework \
  -framework "./build/iphoneos/CleanUI.framework" \
  -framework "./build/iphonesimulator/CleanUI.framework" \
  -output "./build/CleanUI.xcframework"