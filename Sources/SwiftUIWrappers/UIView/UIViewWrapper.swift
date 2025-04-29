import SwiftUI
import UIKit

/// A generic SwiftUI wrapper for any `UIView`.
///
/// Use this struct to embed a `UIView` in a SwiftUI view hierarchy.
///
/// ### Example usage:
/// ```swift
/// UIViewWrapper {
///     MyCustomView()
/// }
/// ```
///
/// Or via the `asSwiftUIView()` extension:
/// ```swift
/// MyCustomView().asSwiftUIView()
/// ```
public struct UIViewWrapper<V: UIView>: UIViewRepresentable {
    
    /// A closure that creates the `UIView` instance.
    private let makeView: () -> V

    /// Initializes the wrapper with a closure to create the view.
    ///
    /// - Parameter makeView: A closure that returns a `UIView` instance.
    init(_ makeView: @escaping () -> V) {
        self.makeView = makeView
    }

    /// Creates the `UIView` instance to be used in SwiftUI.
    ///
    /// - Parameter context: Context provided by SwiftUI.
    /// - Returns: A newly created `UIView` instance.
    public func makeUIView(context: Context) -> V {
        return makeView()
    }

    /// Updates the view with new data from SwiftUI.
    ///
    /// - Parameters:
    ///   - uiView: The view to update.
    ///   - context: Context provided by SwiftUI.
    public func updateUIView(_ uiView: V, context: Context) {
        // No update logic by default.
    }
}
