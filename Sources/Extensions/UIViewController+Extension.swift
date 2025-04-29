import UIKit

extension UIViewController {
    public func inUINavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
    
    public func showAlert(
        title: String? = nil,
        message: String? = nil,
        animated: Bool = true
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        present(alert, animated: animated)
    }
}
