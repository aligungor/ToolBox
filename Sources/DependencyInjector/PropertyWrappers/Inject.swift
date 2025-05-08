//
//  Inject.swift
//

import Foundation

/// Property wrapper that resolves a dependency immediately from the container.
///
/// ### Usage:
/// ```swift
/// @Inject var userService: UserServiceProtocol
/// ```
@MainActor
@propertyWrapper
public struct Inject<T> {
    public var wrappedValue: T

    public init() {
        self.wrappedValue = DependencyInjector.shared.resolve()
    }
}
