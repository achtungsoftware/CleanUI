echo "Remove old xcframework build..."
rm -rf "./build/CleanUI.xcframework"

echo "Remove old frameworks..."
rm -rf "./build/iphoneos"
rm -rf "./build/iphonesimulator-x86_64"
rm -rf "./build/iphonesimulator-arm64"
rm -rf "./build/iphonesimulator-universal"

echo "Make sure the ./build/iphonesimulator-universal folder exist"
mkdir -p "./build/iphonesimulator-universal"
mkdir -p "./build/iphonesimulator-universal/CleanUI.framework" 

echo "Building for iOS..."
xcodebuild archive \
  -scheme "CleanUI" \
  -configuration Release \
  -archivePath "./build/iphoneos/CleanUI.xcarchive" \
  -sdk iphoneos \
  SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

echo "Building for iOS Simulator x86_64..."
xcodebuild archive \
  -scheme "CleanUI" \
  -configuration Release \
  -archivePath "./build/iphonesimulator-x86_64/CleanUI.xcarchive" \
  -sdk iphonesimulator \
  -arch x86_64 \
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
cp -r "./build/iphonesimulator-x86_64/CleanUI.xcarchive/Products/Library/Frameworks/." "./build/iphonesimulator-x86_64"
cp -r "./build/iphonesimulator-arm64/CleanUI.xcarchive/Products/Library/Frameworks/." "./build/iphonesimulator-arm64"
cp -r "./build/iphoneos/CleanUI.xcarchive/Products/Library/Frameworks/." "./build/iphoneos"

echo "Merging iOS Simulator ARM64 and x86_64"
lipo -create -output "./build/iphonesimulator-universal/CleanUI.framework/CleanUI" \
  "./build/iphonesimulator-arm64/CleanUI.framework/CleanUI" \
  "./build/iphonesimulator-x86_64/CleanUI.framework/CleanUI"

echo "Building XCFramework..."
xcodebuild -create-xcframework \
  -framework "./build/iphoneos/CleanUI.framework" \
  -framework "./build/iphonesimulator-universal/CleanUI.framework" \
  -output "./build/CleanUI.xcframework"