import SwiftUI
import UIKit

public extension View {
    /// Wraps the SwiftUI `View` in a `UIHostingController`.
    ///
    /// This is useful when you want to present a SwiftUI view from UIKit code.
    ///
    /// - Returns: A `UIHostingController` instance containing this SwiftUI view.
    ///
    /// ### Example:
    /// ```swift
    /// struct MyView: View {
    ///     var body: some View {
    ///         Text("Hello from SwiftUI")
    ///     }
    /// }
    ///
    /// let vc = MyView().asViewController()
    /// navigationController?.pushViewController(vc, animated: true)
    /// ```
    func asViewController() -> UIHostingController<Self> {
        return UIHostingController(rootView: self)
    }
}
