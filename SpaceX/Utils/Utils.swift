//
//  Utils.swift
//  SpaceX
//
//  Created by Mohammad Ashraful Kabir on 30/01/2022.
//

import Foundation
import UIKit

class Utils {
    static func showErrorAlert(at viewController: UIViewController, with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
