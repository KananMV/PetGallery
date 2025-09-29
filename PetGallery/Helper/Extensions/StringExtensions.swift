import Foundation
import UIKit

extension String {
    var isValidEmail: Bool {
        let emailRegEx =
        "(?:[a-zA-Z0-9!#$%\\&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,}|\\[(?:(2(5[0-5]|[0-4][0-9])|1[0-9]{2}|[1-9]?[0-9]))\\])"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }
    
    func colored(_ color: UIColor, font: UIFont) -> NSAttributedString {
        return NSAttributedString(
            string: self,
            attributes: [
                .foregroundColor: color,
                .font: font
            ]
        )
    }
}
