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
CleanUI views have a ``CL`` prefix. CleanUI helper classes have a ``CU`` prefix.

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

### Custom NavigationBar
```swift
List {
    Text("Item")
}
.navigationBar("MyTitle")

// With a big title
List {
    Text("Item")
}
.navigationBar("MyTitle", bigTitle: true)

// With a NavigationSearchBar and trailing buttons

@StateObject var navigationSearchField: NavigationBarSearchField = NavigationBarSearchField()

List {
    Text("Item")
}
.navigationBar("MyTitle", bigTitle: true, buttons: AnyView(Group {
    Button(action: {
        // Action
    }, label: {
        CLIcon(systemImage: "plus")
    })
}), searchBar: navigationSearchField)
```

### Alerts, Sheets and AlertMessages
CleanUI lets you create Alerts, Sheets and AlertMessages very easily.

To show a Alert from everywhere in code you can do this.
```swift
CUAlert.show(YOUR_VIEW_HERE)

// Clear all Alerts with
CUAlert.clearAll()
```

To show a Sheet from everywhere in code you can do this.
```swift
CUSheet.show(YOUR_VIEW_HERE)

// Clear all Sheets with
CUSheet.clearAll()
```

To show a AlertMessage from everywhere in code you can do this.
```swift
CUAlertMessage.show("HELOOOOO")
CUAlertMessage.show("HELOOOOO", subTitle: "WORLD")

// All styles `CLInfoCard.InfoCardType``
CUAlertMessage.show("HELOOOOO", type: .error)
CUAlertMessage.show("HELOOOOO", subTitle: "WORLD", type: .error)

CUAlertMessage.show("HELOOOOO", type: .success)
CUAlertMessage.show("HELOOOOO", subTitle: "WORLD", type: .success)

CUAlertMessage.show("HELOOOOO", type: .info)
CUAlertMessage.show("HELOOOOO", subTitle: "WORLD", type: .info)
```

