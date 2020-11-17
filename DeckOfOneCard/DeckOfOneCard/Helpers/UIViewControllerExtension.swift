//
//  UIViewControllerExtension.swift
//  DeckOfOneCard
//
//  Created by Jeremy Taylor on 11/17/20.
//

import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        
        // Feel free to customize the alert controller.
        let alertController = UIAlertController(title: "Error", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
