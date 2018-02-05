import UIKit

class ModalViewController: UIViewController {

    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func accessibilityPerformEscape() -> Bool {
        self.dismiss(animated: true, completion: nil)
        return true
    }
}
