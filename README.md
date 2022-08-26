# CleanUI
CleanUI is a collection of Swift and SwiftUI helpers. CleanUI views have a ``CL`` prefix. CleanUI helper classes have a ``CL`` prefix. CleanUI is ripped out of the Knoggl iOS App to make a reusable framework, which can be worked on without directly changing things inside of the Knoggl iOS App.

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
CUSheet.show(_ title: String, subTitle: String = "", type: CLInfoCard.InfoCardType = .info)
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

There is so much more in CleanUI. Just browse through the project to find everything CleanUI has to offer.