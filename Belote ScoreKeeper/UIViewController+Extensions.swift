//
//  UIViewController+Extensions.swift
//  Belote ScoreKeeper
//
//  Created by Vrezh Gulyan on 10/13/20.
//  Copyright © 2020 Revenge Apps Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    public func displayDismissableAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok",
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert,
                animated: true,
                completion: nil)
    }
}
