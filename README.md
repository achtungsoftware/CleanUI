 ### [CleanUI Documentation](https://knoggl.github.io/CleanUI/documentation/cleanui)

# What is CleanUI
CleanUI is a SwiftUI / iOS framework. CleanUI has many things build in to get you started to build your app. CleanUI is ripped out of the [Knoggl iOS App](https://github.com/knoggl/Knoggl-iOS) to make a reusable framework, which can be worked on without directly changing things inside of the [Knoggl iOS App](https://github.com/knoggl/Knoggl-iOS). In other words, CleanUI is the heart of the [Knoggl iOS App](https://github.com/knoggl/Knoggl-iOS).

# Live Preview
You can download the Knoggl-iOS App on the [AppStore](https://apps.apple.com/de/app/knoggl/id1570411915) to have a very detailed preview with things CleanUI provides you.

# What's Inside
CleanUI has many default views from simple to complex. CleanUI allows to make huge changes in your app with as little code as possible.

# How To Use
CleanUI views have a ``CL`` prefix. CleanUI helper classes have a ``CU`` prefix.

# Building The Documentation

1. Build the Documentation with Xcode 13.3 / Swift 5.6
2. Convert the .doccarchive with [docc](https://github.com/apple/swift-docc) to use in static environments, by using the following command ``
swift run docc process-archive transform-for-static-hosting /path/to/CleanUI.doccarchive --output-path /path/to/CleanUI/docs --hosting-base-path /CleanUI``

