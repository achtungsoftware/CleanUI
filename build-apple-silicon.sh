echo "Remove old xcframework build..."
rm -rf "./build/CleanUI.xcframework"

echo "Remove old frameworks..."
rm -rf "./build/iphoneos"
rm -rf "./build/iphonesimulator-arm64"

echo "Building for iOS..."
xcodebuild archive \
  -scheme "CleanUI" \
  -configuration Release \
  -archivePath "./build/iphoneos/CleanUI.xcarchive" \
  -sdk iphoneos \
  SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

echo "Building for iOS Simulator ARM64..."
xcodebuild archive \
  -scheme "CleanUI" \
  -configuration Release \
  -archivePath "./build/iphonesimulator-arm64/CleanUI.xcarchive" \
  -sdk iphonesimulator \
  -arch arm64 \
  SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

echo "Extract the frameworks from the Archives"
cp -r "./build/iphonesimulator-arm64/CleanUI.xcarchive/Products/Library/Frameworks/." "./build/iphonesimulator-arm64"
cp -r "./build/iphoneos/CleanUI.xcarchive/Products/Library/Frameworks/." "./build/iphoneos"


echo "Building XCFramework..."
xcodebuild -create-xcframework \
  -framework "./build/iphoneos/CleanUI.framework" \
  -framework "./build/iphonesimulator-arm64/CleanUI.framework" \
  -output "./build/CleanUI.xcframework"