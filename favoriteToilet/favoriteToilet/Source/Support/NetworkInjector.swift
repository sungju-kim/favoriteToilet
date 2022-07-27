//
//  NetworkInjector.swift
//  favoriteToilet
//
//  Created by dale on 2022/07/27.
//

import Foundation

@propertyWrapper
struct NetworkInjector<T> {
    var wrappedValue: T

    init(keypath: KeyPath<NetworkContainer, T>) {
        let container = NetworkContainer.shared
        wrappedValue = container[keyPath: keypath]
    }
}
