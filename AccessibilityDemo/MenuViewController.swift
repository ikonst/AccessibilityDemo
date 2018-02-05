import UIKit

class MenuViewController: UIViewController {
    @IBOutlet var rideTypeButton: UIButton!
    @IBOutlet var rideTypesView: UIStackView!

    var rideType: String? {
        didSet {
            self.rideTypeButton.setTitle("Ride Type: \(self.rideType ?? "unknown")", for: .normal)
        }
    }

    override func viewDidLoad() {
        self.rideType = "Lyft"
    }

    @IBAction func rideTypeTapped(_ sender: Any) {
        openRideTypeModal()
    }

    override func accessibilityPerformEscape() -> Bool {
        if self.rideTypesView.isHidden {
            return super.accessibilityPerformEscape()
        }

        self.closeRideTypeModal()
        return true
    }

    @IBAction func rideTypeSelected(_ sender: Any) {
        self.rideType = (sender as? UIButton)?.title(for: .normal)
        self.closeRideTypeModal()
    }

    func openRideTypeModal() {
        self.rideTypesView.isHidden = false
        self.rideTypesView.accessibilityViewIsModal = true
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self.rideTypesView.subviews.first)
    }

    func closeRideTypeModal() {
        self.rideTypesView.isHidden = true
        self.rideTypesView.accessibilityViewIsModal = false
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self.rideTypeButton)
    }
}
