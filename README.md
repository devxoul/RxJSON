# RxJSON

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

`mapJSON()` will return `Observable<Any>` if you don't specify the type and `Observable<T>` if you specify the type `T`. It will return `Observable<[String: Any]>` if the element of the source observable is already a json dictionary.

```swift
Observable<Any>.mapJSON("key")           // Observable<Any>
Observable<Any>.mapJSON("key", Int.self) // Observable<Int>
Observable<[String: Any]>.mapJSON("key") // Observable<[String: Any]>
```

`mapJSON()` will throw a `RxJSONError` when there's no value for given key or fails to cast to a given type.

```swift
source.mapJSON("unknownKey") // Event.error(RxJSONError.foundNil)
source.mapJSON("name", Int.key) // Event.error(RxJSONError.failedCasting)
```

## Installation

* **Using [CocoaPods](https://cocoapods.org)**:

    ```ruby
    pod 'RxJSON'
    ```

* **Using [Carthage](https://github.com/Carthage/Carthage)**:


    This is not supported yet. See [Carthage#1945](https://github.com/Carthage/Carthage/pull/1945) for details.

## Contributing

Any discussions and pull requests are welcomed 💖

To create a Xcode project:

```console
$ swift package generate-xcodeproj
```

## License

RxJSON is under MIT license. See the [LICENSE](LICENSE) file for more info.
