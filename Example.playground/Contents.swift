//: A UIKit based Playground for presenting user interface

import RxSwift
import RxSwiftDo

Observable.of("This", "is", "example", "for", "RxSwiftDo")
    .do(events: [.completed]) {
        print("Catch completed event")
        print($0)
    }
    .do(events: [.next, .error]) {
        print("Catch next, error event")
        print($0)
    }
    .do(events: [.subscribe, .subscribed]) {
        print("Catch subscribe, subscribed event")
        print($0)
    }
    .subscribe()
