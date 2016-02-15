#TCCalendar

## Requirements

- iOS 8.0+
- Xcode 7

##Integration

####CocoaPods (iOS 8+)
You can use [CocoaPods](http://cocoapods.org/) to install `TCCalendar` by adding it to your `Podfile`:
```ruby
platform :ios, '8.0'
use_frameworks!

target 'YourApp' do
  pod 'TCCalendar'
end
```
  
####Swift Package Manager
You can use [The Swift Package Manager](https://swift.org/package-manager) to install `TCCalendar` by adding the proper description to your `Package.swift` file:
```swift
import PackageDescription
  
let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .Package(url: "https://github.com/cyrilwei/TCCalendar.git", versions: "0.1" ..< Version.max)
    ]
)
```
