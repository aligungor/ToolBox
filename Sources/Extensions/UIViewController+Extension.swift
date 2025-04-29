import UIKit

public extension UIViewController {
    func inNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
    
    func showAlert(
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
