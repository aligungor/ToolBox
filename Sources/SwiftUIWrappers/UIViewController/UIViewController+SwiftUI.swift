import SwiftUI
import UIKit

/// A convenience extension to easily embed any `UIViewController` in SwiftUI.
extension UIViewController {
    
    /// Wraps this `UIViewController` in a SwiftUI-compatible view.
    ///
    /// Example usage:
    /// ```swift
    /// MyViewController().asSwiftUIView()
    /// ```
    /// - Returns: A SwiftUI view that hosts this view controller.
    func asSwiftUIView() -> some View {
        UIViewControllerWrapper { self }
    }
}
