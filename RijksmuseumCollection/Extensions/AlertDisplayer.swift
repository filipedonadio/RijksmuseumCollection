//
//  AlertDisplayer.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 28/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import UIKit

protocol AlertDisplayer {

    func displayAlert(with title: String, message: String, actions: [UIAlertAction]?)
}

extension AlertDisplayer where Self: UIViewController {
    
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else {
            return
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }

        present(alertController, animated: true)
    }
}
