import SwiftUI
import UIKit

/// A generic SwiftUI wrapper for any `UIViewController`.
///
/// Use this struct to embed a `UIViewController` in a SwiftUI view hierarchy.
///
/// Example usage:
/// ```swift
/// UIViewControllerWrapper {
///     MyViewController()
/// }
/// ```
///
/// Or via the `asSwiftUIView()` extension:
/// ```swift
/// MyViewController().asSwiftUIView()
/// ```
struct UIViewControllerWrapper<VC: UIViewController>: UIViewControllerRepresentable {
    
    /// A closure that creates the `UIViewController` instance.
    private let makeViewController: () -> VC

    /// Initializes the wrapper with a factory closure.
    ///
    /// - Parameter makeViewController: A closure that returns a `UIViewController` instance.
    init(_ makeViewController: @escaping () -> VC) {
        self.makeViewController = makeViewController
    }

    /// Creates the `UIViewController` instance.
    ///
    /// - Parameter context: Context provided by SwiftUI.
    /// - Returns: A newly created `UIViewController` instance.
    func makeUIViewController(context: Context) -> VC {
        return makeViewController()
    }

    /// Updates the view controller with new data from SwiftUI.
    ///
    /// - Parameters:
    ///   - uiViewController: The view controller to update.
    ///   - context: Context provided by SwiftUI.
    func updateUIViewController(_ uiViewController: VC, context: Context) {
        // No update logic by default.
    }
}
