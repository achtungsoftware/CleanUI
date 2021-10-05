# CleanUI

## What is CleanUI
CleanUI is a SwiftUI / Swift framework for easy ui, and backend creation. CleanUI has everything build in to get you started to build your app.

## What's inside
CleanUI has many default views from simple to complex. CleanUI allows to make huge changes in your app with little code as possible. Besides that, CleanUI contains many swift extension, helper classes (for example for networking)

## Http helper examples

#### Simple ``Http.post`` request
Make a simple http post request and get the success bool and the result string
```swift
Http.post("example.com/post", parameters: [
    "parameter": value
]) { (result, success) -> () in
    if(success){

    }
}
```

#### Simple ``Http.postObject`` request
Make a http post request and get an object with a defined type, the success bool and the result string
```swift
Http.postObject("example.com/postObject", parameters: [
    "parameter": value
], type: MyType.self){ (object, result, success) -> () in
	if(success){
	
	}
}
```

#### Simple ``Http.postObjectArray`` request
Make a http post request and get an object array with a defined type, the success bool and the result string
```swift
Http.postObject("example.com/postObjectArray", parameters: [
    "parameter": value
], type: MyType.self){ (array, result, success) -> () in
	if(success){
	
	}
}
```

## View examples
```swift
// Icon
Icon("MyIcon", size: .small)
Icon(systemImage: "SystemIcon", size: .large)
Icon(systemImage: "SystemIcon", newBadge: true, size: .large)
Icon("MyIcon", newBadge: true, size: .large, isImageOverlay: true)
Icon("MyIcon", newBadge: true, size: .large, isImageOverlay: true, offset: .leading(20))
```

