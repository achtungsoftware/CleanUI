# CleanUI

Build with
```console
xcodebuild archive \
-scheme CleanUI \        
-configuration Release \
-destination 'generic/platform=iOS' \
-archivePath './build/CleanUI.framework-iphoneos.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
```
