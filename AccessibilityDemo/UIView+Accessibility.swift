import UIKit

private struct AssociatedKeys {
    static var accessibilitySources: UInt8 = 0
}

/// The format for representing self when using accessibilityFormat
private let AccessibilityFormatSelf = "self"

private extension String {
    /// Formats a string from a template containing identifiers in the form of `[identifier]`.
    ///
    /// - parameter template: the template
    /// - parameter resolver: a closure that resolves identifier names to values
    init(template: String, resolver: (String) -> String) {
        self.init()
        self.reserveCapacity(256)
        var identifierStartIndex: String.Index?
        for index in template.indices {
            switch template[index] {
            case "[":
                identifierStartIndex = template.index(after: index)
            case "]":
                if let identifierStartIndex = identifierStartIndex {
                    self += resolver(String(template[identifierStartIndex..<index]))
                }
                identifierStartIndex = nil
            default:
                if identifierStartIndex == nil {
                    self.append(template[index])
                }
            }
        }
    }
}

extension UIView {
    /// An IBOutletCollection of views to use to build the button's accessibilityLabel
    /// if this array is empty the button's label is used
    @IBOutlet public var accessibilitySources: [UIView]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.accessibilitySources) as? [UIView]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.accessibilitySources, newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var instrinsicAccessibilityLabel: String? {
        if self.accessibilitySources?.isEmpty != false {
            return super.accessibilityLabel
        }

        switch self {
        case let button as UIButton:
            return button.title(for: button.state)
        case let label as UILabel:
            return label.text
        default:
            return nil
        }
    }

    var formattedAccessibilityLabel: String? {
        guard let format = super.accessibilityLabel, !format.isEmpty else {
            return self.instrinsicAccessibilityLabel
        }

        return String(template: format, resolver: { identifier in
            if identifier == AccessibilityFormatSelf {
                return self.instrinsicAccessibilityLabel ?? ""
            }

            let source = self.accessibilitySources?.first(where: { $0.accessibilityIdentifier == identifier })
            return source?.accessibilityLabel ?? ""
        })
    }

    open override var accessibilityLabel: String? {
        set { super.accessibilityLabel = newValue }
        get { return self.formattedAccessibilityLabel }
    }
}
