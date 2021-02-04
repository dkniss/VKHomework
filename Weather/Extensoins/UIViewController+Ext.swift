//
//  UIViewController+Ext.swift
//  Weather
//
//  Created by Daniil Kniss on 04.02.2021.
//

import UIKit

extension UIViewController {
    func show(_ error: Error) {
        let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler:)
        present(alertVC, animated: true)
    }
}
