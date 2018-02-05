import UIKit

class FocusOrderViewController: UIViewController {
    /// A view that should receive the VoiceOver focus ring (cursor) when the view controller appears
    /// instead of the first (top left) element.
    @IBOutlet public var voiceOverInitialFocusView: UIView?

    @IBOutlet var label: UILabel!

    let pointSize = CGFloat(17)
    var fontDescriptor = UIFontDescriptor()

    var fontName: String! {
        didSet {
            self.fontDescriptor = self.fontDescriptor.withFamily(self.fontName)
            self.label.font = UIFont(descriptor: self.fontDescriptor, size: self.pointSize)
        }
    }

    @IBAction func font1Tapped(_ sender: Any) {
        self.fontName = "Helvetica"
    }

    @IBAction func font2Tapped(_ sender: Any) {
        self.fontName = "Times New Roman"
    }

    @IBAction func font3Tapped(_ sender: Any) {
        self.fontName = "Chalkduster"
    }

    @IBAction func boldTapped(_ sender: Any) {
        self.fontDescriptor = self.fontDescriptor.withSymbolicTraits(.traitBold) ?? self.fontDescriptor
        self.label.font = UIFont(descriptor: self.fontDescriptor, size: self.pointSize)
    }

    @IBAction func italicTapped(_ sender: Any) {
        self.fontDescriptor = self.fontDescriptor.withSymbolicTraits(.traitItalic) ?? self.fontDescriptor
        self.label.font = UIFont(descriptor: self.fontDescriptor, size: self.pointSize)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let voiceOverInitialFocusView = self.voiceOverInitialFocusView {
            UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification,
                                            voiceOverInitialFocusView)
        }

        self.fontName = "Helvetica"
    }
}
