//
//  PublishBindable.swift
//  RedditDemoApp
//
//  Created by Alonso on 21/11/22.
//

import Dispatch

final class PublishBindable<T>: Bindable {

    typealias Listener = ((T) -> Void)
    private var listener: Listener?

    private var dispatchQueue: DispatchQueue?

    func bind(_ listener: @escaping Listener, on dispatchQueue: DispatchQueue? = nil) {
        self.listener = listener
        self.dispatchQueue = dispatchQueue
    }

    func bindAndFire(_ listener: @escaping Listener, on dispatchQueue: DispatchQueue?) {
        assertionFailure("Bind and fire method is not supported for a PublishBindable")
    }

    func send(_ value: T) {
        if let dispatchQueue = dispatchQueue {
            dispatchQueue.async { self.listener?(value) }
        } else {
            self.listener?(value)
        }
    }

}

extension PublishBindable where T == Void {

    func send() {
        send(())
    }

}
