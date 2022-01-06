# Swift Package Manager
Get this package with the Swift Package Manager
```swift
.package(url: "https://github.com/knoggl/CleanUI.git", .upToNextMinor(from: "1.0.0")),
```

# What is CleanUI
CleanUI is a SwiftUI / iOS framework. CleanUI has many things build in to get you started to build your app. CleanUI is ripped out of the [Knoggl iOS App](https://github.com/knoggl/Knoggl-iOS) to make a reusable framework, which can be worked on without directly changing things inside of the [Knoggl iOS App](https://github.com/knoggl/Knoggl-iOS). In other words, CleanUI is the heart of the [Knoggl iOS App](https://github.com/knoggl/Knoggl-iOS).

# Live Preview
You can download the Knoggl-iOS App on the [AppStore](https://apps.apple.com/de/app/knoggl/id1570411915) to have a very detailed preview, what CleanUI can provide you.

# What's inside
CleanUI has many default views from simple to complex. CleanUI allows to make huge changes in your app with as little code as possible.

# How to use
CleanUI views have a 'CL' prefix. CleanUI helper classes have a 'CU' prefix.

# Examples

### Programmatic Navigation
```swift
NavigationView {
    Button(action: {
      CUNavigation.pushToSwiftUiView(YOUR_VIEW_HERE)
    }){
      Text("Push To SwiftUI View")
    }
    
    Button(action: {
      CUNavigation.popToRootView()
    }){
      Text("Pop to the Root View")
    }
    
    Button(action: {
      CUNavigation.pushBottomSheet(YOUR_VIEW_HERE)
    }){
      Text("Push to a Botton-Sheet")
    }
}
```


