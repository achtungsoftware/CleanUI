[![Swift](https://img.shields.io/badge/Swift-5.5-brightgreen.svg?colorA=orange&colorB=4F4F4F)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-15-brightgreen.svg?colorA=orange&colorB=4F4F4F)](https://www.apple.com/ios)
[![Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg?colorA=orange&colorB=4F4F4F)](https://www.apache.org/licenses/LICENSE-2.0)

# CleanUI
CleanUI is a collection of Swift and SwiftUI helpers. CleanUI views have a ``CL`` prefix. CleanUI helper classes have a ``CU`` prefix. CleanUI is ripped out of the Knoggl iOS App to make a reusable framework, which can be worked on without directly changing things inside of the Knoggl iOS App.

# Examples
The following list of examples is just a small list to show what CleanUI can do.

# Import
```swift
import CleanUI
```

## Helpers
CleanUI has some really cool helper classes.

### CUAlert
```swift
// Shows an alert with the given SwiftUI.View
CUAlert.show(YOUR_SWIFTUI_VIEW)

// Clears all alerts
CUAlert.clearAll()
```

### CUSheet
```swift
// Shows an sheet with the given SwiftUI.View
CUSheet.show(YOUR_SWIFTUI_VIEW)

// Clears all sheets
CUSheet.clearAll()
```

### CUAlertMessage
```swift
// Shows an alert message with the given title, subTitle and type
CUAlertMessage.show(_ title: String, subTitle: String = "", type: CLInfoCard.InfoCardType = .info)
```

### CUNavigation
CUNavigation does its best to find the current UINavigationView inside the view hierarchy and gives you some basic functionality which are still missing in SwiftUI.
```swift
// Try's to pop to the rootViewController / View inside of the current UINavigationController
CUNavigation.popToRootView()

// Try's to pop the current view to navigate one step back
CUNavigation.pop()

// Try's to push to a SwiftUI View inside the current UINavigationController
CUNavigation.pushToSwiftUiView(YOUR_SWIFTUI_VIEW)
```

## Views
Some of CleanUI's views

### CLIcon
Perfect sized icons with more functionality.
```swift
// A small icon
CLIcon(systemImage: "clock", size: .small)

// An icon with a newBadge and trailing offset
CLIcon(systemImage: "clock", newBadge: true, offset: .trailing(16))

// A tappable icon with newBadge
CLIcon(systemImage: "clock", newBadge: true) {
    CUAlertMessage.show("Tapped")
}
```

### CLRichText
Richtext with optional link, hashtag and mention detection and tap actions.
```swift

let text = "Hello @CleanUI! I love #Knoggl. Go visit www.knoggl.com"

// All attributes
CLRichText(text, attributes: [
    .links(onTapAction: { linkString in
        // Open link in CUBrowser
        CUBrowser.open(linkString)
    }),
    .hashtags(onTapAction: { hashtag in
        // Push to hashtags page?
        CUNavigation.pushToSwiftUiView(YOUR_SWIFTUI_VIEW)
    }),
    .mentions(onTapAction: { mention in
        // Push to profile?
        CUNavigation.pushToSwiftUiView(YOUR_SWIFTUI_VIEW)
    }),
])

// Only links
CLRichText(text, attributes: [
    .links(onTapAction: { linkString in
        // Open link in CUBrowser
        CUBrowser.open(linkString)
    }),
])
```

### CLScrollView
With CLScrollView you can track the current scroll offset.
```swift
CLScrollView(offsetChanged: { 
    print("Offset has changed: \($0.y)")
}) {
    VStack {
        Text("Hello CleanUI! Hello Knoggl!")
        Text("Hello CleanUI! Hello Knoggl!")
        Text("Hello CleanUI! Hello Knoggl!")
        Text("Hello CleanUI! Hello Knoggl!")
        Text("Hello CleanUI! Hello Knoggl!")
    }
}
```

### CLDateTime
CLDateTime gives you a human readable represantation of a ``ISO8601`` date string.
```swift
// Without T seperator
CLDateTime("2022-05-11 00:54:06")

// With T seperator
CLDateTime("2022-06-11T10:56:45")
```

### CLUrlImage
CLUrlImage downloads the given image and displays it.
```swift
CLUrlImage("MY_IMAGE_URL_STRING")

// You can set a fallback image
CLUrlImage("MY_IMAGE_URL_STRING", fallbackImage: MY_UIIMAGE)
```

## Modifiers
CleanUI has some pretty cool SwiftUI modifiers.

### OnLoad (.onLoad)
The OnLoad modifier is pretty much the same as .onAppear with the difference, that .onLoad is called only once.
```swift
MyView()
    .onLoad {
        // Gets called only on the first onAppear
        print("Hallo, Welt!")
    }
```

### OnRotate (.onRotate)
OnRotate fires everytime the device rotates and returns the current ``UIDeviceOrientation``.
```swift
MyView()
    .onRotate { rotation in
        // Do something with the rotation
    }
```

### PinchToZoom (.pinchToZoom)
The PinchToZoom modifier allows pinching the view its attached to.
```swift
MyView()
    .pinchToZoom()
```

# Summary
There is so much more in CleanUI. Just browse through the project to find everything CleanUI has to offer. Feel free to contribute!
