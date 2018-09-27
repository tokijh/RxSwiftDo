//
//  DoTests.swift
//  RxSwiftDoTests
//
//  Created by 윤중현 on 2018. 9. 27..
//  Copyright © 2018년 윤중현. All rights reserved.
//

import XCTest
import RxSwift

class DoTests: XCTestCase {

    func testObservableDoEvent() {
        var eventLog: [String] = []
        var disposable: Disposable?
        disposable = Observable.of(Array(0..<10))
            .do { (event) in
                eventLog.append(event.debugDescription)
            }
            .subscribe()
        disposable?.dispose()
        XCTAssertEqual(eventLog, ["subscribe", "subscribed", "next([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])", "completed", "dispose"])
    }
    
    func testObservableDoFilterdEvent() {
        var eventLog: [String] = []
        var disposable: Disposable?
        disposable = Observable.of(Array(0..<10))
            .do(events: [.next, .dispose]) { (event) in
                eventLog.append(event.debugDescription)
            }
            .subscribe()
        disposable?.dispose()
        XCTAssertEqual(eventLog, ["next([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])", "dispose"])
    }
}
