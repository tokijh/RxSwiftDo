//
//  Do.swift
//  RxDo
//
//  Created by tokijh on 2018. 3. 11..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift

public extension ObservableType {
    /**
     Invokes an event handler to an observable sequence.
     
     - seealso: [do operator on reactivex.io](http://reactivex.io/documentation/operators/do.html)
     
     - parameter on: Action to invoke for each event in the observable sequence.
     - returns: The source sequence with the side-effecting behavior applied.
     */
    public func `do`(on: @escaping (Event<Self.E>) -> Swift.Void) -> Observable<E> {
        return self
            .do(onNext: {
                on(Event<`Self`.E>.next($0))
            }, onError: {
                on(Event<`Self`.E>.error($0))
            }, onCompleted: {
                on(Event<`Self`.E>.completed)
            }, onSubscribe: {
                on(Event<`Self`.E>.subscribe)
            }, onSubscribed: {
                on(Event<`Self`.E>.subscribed)
            }, onDispose: {
                on(Event<`Self`.E>.dispose)
            })
    }
    
    /**
     Invokes filtered event handler to an observable sequence.
     
     
     - parameter events: Listener event type
     - parameter on: Action to invoke for filtered event in the observable sequence.
     - returns: The source sequence with the side-effecting behavior applied.
     */
    public func `do`(events: [EventFilter], on: @escaping (Event<Self.E>) -> Swift.Void) -> Observable<E> {
        return self.do { e in
            if events.contains(where: { $0 == e }) { on(e) }
        }
    }
}

/// Represents a sequence event.
public enum Event<Element> {
    case next(Element)  // Action to invoke for each element in the observable sequence.
    case error(Error)   // Action to invoke upon errored termination of the observable sequence.
    case completed      // Action to invoke upon graceful termination of the observable sequence.
    case subscribe      // Action to invoke before subscribing to source observable sequence.
    case subscribed     // Action to invoke after subscribing to source observable sequence.
    case dispose        // Action to invoke after subscription to source observable has been disposed for any reason. It can be either because sequence terminates for some reason or observer subscription being disposed.
}

/// Event Filter Type
public enum EventFilter {
    case next
    case error
    case completed
    case subscribe
    case subscribed
    case dispose
}

extension Event: CustomDebugStringConvertible {
    /// - returns: Description of event.
    public var debugDescription: String {
        switch self {
        case .next(let value): return "next(\(value))"
        case .error(let error): return "error(\(error))"
        case .completed: return "completed"
        case .subscribe: return "subscribe"
        case .subscribed: return "subscribed"
        case .dispose: return "dispose"
        }
    }
}

extension Event {
    static func == (lhs: Event, rhs: Event) -> Bool {
        switch lhs {
        case .subscribe: return rhs.isSubscribe
        case .subscribed: return rhs.isSubscribed
        case .next: return rhs.isNext
        case .error: return rhs.isError
        case .completed: return rhs.isCompleted
        case .dispose: return rhs.isDispose
        }
    }
    
    static func == (lhs: EventFilter, rhs: Event) -> Bool {
        switch lhs {
        case .subscribe: return rhs.isSubscribe
        case .subscribed: return rhs.isSubscribed
        case .next: return rhs.isNext
        case .error: return rhs.isError
        case .completed: return rhs.isCompleted
        case .dispose: return rhs.isDispose
        }
    }
    
    static func == (lhs: Event, rhs: EventFilter) -> Bool {
        return rhs == lhs
    }
}

extension Event {
    /// Is `error` or `completed` or `dispose` event.
    public var isStopEvent: Bool {
        switch self {
        case .next, .subscribe, .subscribed: return false
        case .error, .completed, .dispose: return true
        }
    }
    
    /// If `next` event, returns element value.
    public var element: Element? {
        if case .next(let value) = self {
            return value
        }
        return nil
    }
    
    /// If `error` event, returns error.
    public var error: Error? {
        if case .error(let error) = self {
            return error
        }
        return nil
    }
    
    /// If `next` event, returns true.
    public var isNext: Bool {
        if case .next = self {
            return true
        }
        return false
    }
    
    /// If `error` event, returns true.
    public var isError: Bool {
        if case .error = self {
            return true
        }
        return false
    }
    
    /// If `completed` event, returns true.
    public var isCompleted: Bool {
        if case .completed = self {
            return true
        }
        return false
    }
    
    /// If `subscribe` event, returns true.
    public var isSubscribe: Bool {
        if case .subscribe = self {
            return true
        }
        return false
    }
    
    /// If `subscribed` event, returns true.
    public var isSubscribed: Bool {
        if case .subscribed = self {
            return true
        }
        return false
    }
    
    /// If `dispose` event, returns true.
    public var isDispose: Bool {
        if case .dispose = self {
            return true
        }
        return false
    }
}

extension Event {
    /// Maps sequence elements using transform. If error happens during the transform .error
    /// will be returned as value
    public func map<Result>(_ transform: (Element) throws -> Result) -> Event<Result> {
        do {
            switch self {
            case let .next(element): return .next(try transform(element))
            case let .error(error): return .error(error)
            case .completed: return .completed
            case .subscribe: return .subscribe
            case .subscribed: return .subscribed
            case .dispose: return .dispose
            }
        } catch let e {
            return .error(e)
        }
    }
}

/// A type that can be converted to `Event<Element>`.
public protocol EventConvertible {
    /// Type of element in event
    associatedtype ElementType
    
    /// Event representation of this instance
    var event: Event<ElementType> { get }
}

extension Event : EventConvertible {
    /// Event representation of this instance
    public var event: Event<Element> {
        return self
    }
}

