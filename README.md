#  RxSwiftDo

[![License](http://img.shields.io/badge/License-MIT-green.svg?style=flat)](https://github.com/tokijh/RxSwiftDo/blob/master/LICENSE)
[![Swift 4](https://img.shields.io/badge/swift-4.0-orange.svg?style=flat)](https://swift.org)

Simplified `Observable.do(onNext, onError ...)` to `Observable.do(on: Event<Value>)` like `subscribe`

## Detail

**New**
```
.do { (event: Event<Value>) in
    print(event)
}

OR

.do (on: { (event: Event<Value>) in
    print(event)
})
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

## Author
[tokijh](https://github.com/tokijh)

## License
RxSwift MVVM TableView is available under the MIT License See the [LICENSE](LICENSE) file for more info.
