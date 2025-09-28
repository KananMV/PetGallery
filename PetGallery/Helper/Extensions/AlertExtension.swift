//
//  AlertExtension.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 26.09.25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, buttonTitle: String = "OK") {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        present(alert, animated: true)
    }
}
