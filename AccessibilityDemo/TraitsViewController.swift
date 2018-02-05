import UIKit

class AdjustableTip: UILabel {
    var tipAmount = 0 {
        didSet {
            self.accessibilityValue = "$\(self.tipAmount)"
            self.text = "Adjustable Tip: $\(self.tipAmount)"
        }
    }

    override func accessibilityIncrement() {
        self.tipAmount += 1
    }

    override func accessibilityDecrement() {
        self.tipAmount = max(self.tipAmount - 1, 0)
    }
}

class SelectableLabel: UILabel {
    var isSelected = false {
        didSet {
            if self.isSelected {
                self.accessibilityTraits |= UIAccessibilityTraitSelected
            } else {
                self.accessibilityTraits &= ~UIAccessibilityTraitSelected
            }
            self.backgroundColor = self.isSelected ? .green : nil
        }
    }

    override func accessibilityActivate() -> Bool {
        self.isSelected = !self.isSelected
        return true
    }
}

class TraitsViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var timeFrequentLabel: UILabel!
    var timer: Timer?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            let text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .long)
            self?.timeLabel.text = text
            self?.timeFrequentLabel.text = text
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
        self.timer = nil
    }
}
