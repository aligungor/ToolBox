//
//  Provider.swift
//

import Foundation

/// Property wrapper that registers a dependency to the container.
///
/// ### Usage:
/// ```swift
/// @Provider var apiClient = APIClient() as APIClientProtocol
/// ```
@MainActor
@propertyWrapper
public struct Provider<T> {
    public var wrappedValue: T

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        DependencyInjector.shared.register(wrappedValue)
    }
}
