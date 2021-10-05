# CleanUI

## What is CleanUI
CleanUI is a SwiftUI / Swift framework for easy ui, and backend creation. CleanUI has everything build in to get you started to build your app.

## What's inside
CleanUI has many default views from simple to complex. CleanUI allows to make huge changes in your app with little code as possible. Besides that, CleanUI contains many swift extension, helper classes (for example for networking)

### Http helper examples

#### Simple ``Http.post`` request
```swift
Http.post("example.com/post", parameters: [
    "parameter": value
]) { (result, success) -> () in
    if(success){

    }
}
```
