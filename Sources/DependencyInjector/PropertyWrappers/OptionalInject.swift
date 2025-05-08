//
//  OptionalInject.swift
//

import Foundation

/// Property wrapper that optionally resolves a dependency. Returns nil if not registered.
///
/// ### Usage:
/// ```swift
/// @OptionalInject var analytics: AnalyticsServiceProtocol?
/// ```
@MainActor
@propertyWrapper
public struct OptionalInject<T> {
    public var wrappedValue: T?

    public init() {
        self.wrappedValue = DependencyInjector.shared.resolveOptional()
    }
}
