# SimpleAnimation

[![CI Status](https://travis-ci.org/keithito/SimpleAnimation.svg?branch=master)](https://travis-ci.org/keithito/SimpleAnimation)
[![Version](https://img.shields.io/cocoapods/v/SimpleAnimation.svg?style=flat)](http://cocoapods.org/pods/SimpleAnimation)
[![License](https://img.shields.io/cocoapods/l/SimpleAnimation.svg?style=flat)](http://cocoapods.org/pods/SimpleAnimation)
[![Platform](https://img.shields.io/cocoapods/p/SimpleAnimation.svg?style=flat)](http://cocoapods.org/pods/SimpleAnimation)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


**SimpleAnimation is a UIView extension that makes adding basic animations, like fades and bounces, simple...**

```swift
view.bounceIn(from: .left)
```
<img src="screenshots/bounceIn.gif" width="240" height="209">


**...with sensible defaults...**

```swift
view.popIn()
```
<img src="screenshots/popIn.gif" width="240" height="212">


**...while remaining customizable**

```swift
view.shake(toward: .top, amount: 0.5, duration: 2, delay: 0.5)
```
<img src="screenshots/customShake.gif" width="240" height="212">


## Installation

### CocoaPods

To integrate SimpleAnimation into a project using [CocoaPods](http://cocoapods.org), add the following to your `Podfile`:

```ruby
pod "SimpleAnimation"
```



### Carthage

To integrate SimpleAnimation into a project using [Carthage](https://github.com/Carthage/Carthage), add the following to your `Cartfile`:

```
github "keithito/SimpleAnimation"
```


### Older Xcode Versions

If you are using Xcode 8 to build your project, you need to use version **0.3.2** of SimpleAnimation.
You can do so by specifying the version number in your Podfile or Cartfile.



## Supported Animations

The following animations are supported so far:
  * fadeIn
  * fadeOut
  * fadeColor
  * slideIn
  * slideOut
  * bounceIn
  * bounceOut
  * popIn
  * popOut
  * hop
  * shake

Please see the [example ViewController](Example/Source/ViewController.swift) for more usage examples.
To build the example in XCode, open Example/Example.xcodeproj.


## License

SimpleAnimation is available under the MIT license. See the LICENSE file for more info.
