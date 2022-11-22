//
//  Bindable.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

final class Bindable_Deprecated<T> {

    typealias Listener = ((T) -> Void)
    private var listener: Listener?

    private var dispatchQueue: DispatchQueue?

    var value: T {
        didSet {
            sendValue()
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: Listener?, on dispatchQueue: DispatchQueue? = nil) {
        self.listener = listener
        self.dispatchQueue = dispatchQueue
    }

    func bindAndFire(_ listener: Listener?, on dispatchQueue: DispatchQueue? = nil) {
        self.listener = listener
        self.dispatchQueue = dispatchQueue
        sendValue()
    }

    // MARK: - Private

    private func sendValue() {
        if let dispatchQueue = dispatchQueue {
            dispatchQueue.async { self.listener?(self.value) }
        } else {
            self.listener?(self.value)
        }
    }

}

extension Bindable_Deprecated where T == Void {

    func fire() {
        sendValue()
    }

}
