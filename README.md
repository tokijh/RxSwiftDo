# RxSwiftDo

[![Swift 4.2](https://img.shields.io/badge/swift-4.2-orange.svg?style=flat)](https://swift.org)
[![Version](https://img.shields.io/cocoapods/v/RxSwiftDo.svg?style=flat)](http://cocoapods.org/pods/RxSwiftDo)
[![License](https://img.shields.io/cocoapods/l/RxSwiftDo.svg?style=flat)](http://cocoapods.org/pods/RxSwiftDo)
[![Platform](https://img.shields.io/cocoapods/p/RxSwiftDo.svg?style=flat)](http://cocoapods.org/pods/RxSwiftDo)

Simplified `Observable.do(onNext, onError ...)` to `Observable.do(on: Event<Value>)` like `Observable.subscribe(on: Event<Value>)`

## Notice
> Version 2.1.2
* **SUPPORT SWIFT 4.2**
* Support Carthage

## Detail

**New**
```
.do { (event: Event<Value>) in
    print(event)
}

OR

.do(on: { (event: Event<Value>) in
    print(event)
})

Add filter Event

.do(events: [.next, .error], on: { (event: Event<Value>) in
    print(event)
})
.do(events: [.subscribe, .subscribed]) { (event: Event<Value>) in
    print(event)
}
```
 **Previous**
```
.do(onNext: { (value) in
    print("next(\(value))")
}, onError: { (error) in
    print("error(\(error))")
}, onCompleted: {
    print("completed")
}, onSubscribe: {
    print("subscribe")
}, onSubscribed: {
    print("subscribed")
}, onDispose: {
    print("dispose")
})
```

### Event
```
enum Event<Element> {
    case next(Element)  // Action to invoke for each element in the observable sequence.
    case error(Error)   // Action to invoke upon errored termination of the observable sequence.
    case completed      // Action to invoke upon graceful termination of the observable sequence.
    case subscribe      // Action to invoke before subscribing to source observable sequence.
    case subscribed     // Action to invoke after subscribing to source observable sequence.
    case dispose        // Action to invoke after subscription to source observable has been disposed for any reason. It can be either because sequence terminates for some reason or observer subscription being disposed.
}
```
### EventFilter
```
enum EventFilter {
    case next  // Action to invoke for each element in the observable sequence.
    case error   // Action to invoke upon errored termination of the observable sequence.
    case completed      // Action to invoke upon graceful termination of the observable sequence.
    case subscribe      // Action to invoke before subscribing to source observable sequence.
    case subscribed     // Action to invoke after subscribing to source observable sequence.
    case dispose        // Action to invoke after subscription to source observable has been disposed for any reason. It can be either because sequence terminates for some reason or observer subscription being disposed.
}
```

## Installation

### CocoaPods
RxSwiftDo is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxSwiftDo'
```

### Carthage
Add this to Cartfile

```
github "tokijh/RxSwiftDo" ~> 1.2.2
```
```
$ carthage update
```

## Author
[tokijh](https://github.com/tokijh)

## License
RxSwiftDo is available under the MIT License See the [LICENSE](LICENSE) file for more info.

