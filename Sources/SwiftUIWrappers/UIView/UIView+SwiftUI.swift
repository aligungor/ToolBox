import SwiftUI
import UIKit

/// A convenience extension to easily embed any `UIView` in SwiftUI.
extension UIView {
    
    /// Wraps this `UIView` in a SwiftUI-compatible view.
    ///
    /// ### Example usage:
    /// ```swift
    /// MyCustomView().asSwiftUIView()
    /// ```
    /// - Returns: A SwiftUI view that hosts this `UIView`.
    func asSwiftUIView() -> some View {
        UIViewWrapper { self }
    }
}
