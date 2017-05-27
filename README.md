# RxViewController

![Swift](https://img.shields.io/badge/Swift-3.1-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/RxJSON.svg)](https://cocoapods.org/pods/RxJSON)
[![Build Status](https://travis-ci.org/devxoul/RxJSON.svg?branch=master)](https://travis-ci.org/devxoul/RxJSON)
[![codecov](https://img.shields.io/codecov/c/github/devxoul/RxJSON.svg)](https://codecov.io/gh/devxoul/RxJSON)

RxSwift wrapper for JSON.

## At a Glance

This is an example of converting a json dictionary observable to a string observable:

```swift
URLSession.shared.rx.json(url: "https://api.github.com/repos/ReactorKit/ReactorKit")
  .mapJSON("owner")              // Observable<Any> -> Observable<Any>
  .mapJSON("login", String.self) // Observable<Any> -> Observable<String>
  .bind(to: ownerNameLabel.rx.text)
```

`mapJSON()` will return `Observable<Any>` if you don't specify the type and `Observable<T>` if you specify the type `T`. For example:

```swift
source.mapJSON("key")           // Observable<Any>
source.mapJSON("key", Int.self) // Observable<Int>
```

## Installation

* **Using [CocoaPods](https://cocoapods.org)**:

    ```ruby
    pod 'RxJSON'
    ```

* **Using [Carthage](https://github.com/Carthage/Carthage)**:


    This is not supported yet. See [Carthage#1945](https://github.com/Carthage/Carthage/pull/1945) for details.

## License

RxViewController is under MIT license. See the [LICENSE](LICENSE) file for more info.
