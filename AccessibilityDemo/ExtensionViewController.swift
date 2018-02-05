import UIKit

class AccessibleLabel: UILabel {
    override var accessibilityLabel: String? {
        set { super.accessibilityLabel = newValue }
        get { return self.formattedAccessibilityLabel }
    }
}

class AccessibleButton: UIButton {
    override var accessibilityLabel: String? {
        set { super.accessibilityLabel = newValue }
        get { return self.formattedAccessibilityLabel }
    }
}

class ExtensionViewController: UIViewController {
    @IBInspectable public var foo: String? {
        didSet {
            print(self.foo ?? "unknown")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
