//
//  LazyInject.swift
//

import Foundation

/// Property wrapper that lazily resolves a dependency on first access.
///
/// ### Usage:
/// ```swift
/// @LazyInject var logger: LoggerProtocol
/// ```
@MainActor
@propertyWrapper
public final class LazyInject<T> {
    private lazy var value: T = DependencyInjector.shared.resolve()

    public var wrappedValue: T {
        value
    }

    public init() {}
}
