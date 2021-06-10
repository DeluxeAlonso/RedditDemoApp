//
//  KeychainStorage.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

@propertyWrapper
struct KeychainStorage {

    private let key: String
    private lazy var keychain = KeychainSwift()

    init(key: String) {
        self.key = key
    }

    var wrappedValue: String? {
        mutating get {
            return keychain.get(key)
        }
        set {
            if let newValue = newValue {
                keychain.set(newValue, forKey: key)
            } else {
                keychain.delete(key)
            }
        }
    }

}
