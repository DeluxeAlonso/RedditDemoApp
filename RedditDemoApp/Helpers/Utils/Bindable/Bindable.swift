//
//  Bindable.swift
//  RedditDemoApp
//
//  Created by Alonso on 20/11/22.
//

import Dispatch

protocol Bindable {

    associatedtype Model

    func bind(_ listener: @escaping ((Model) -> Void), on dispatchQueue: DispatchQueue?)
    func bindAndFire(_ listener: @escaping ((Model) -> Void), on dispatchQueue: DispatchQueue?)

}
