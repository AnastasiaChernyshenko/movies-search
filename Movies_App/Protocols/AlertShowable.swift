//
//  AlertShowable.swift
//  Movies_App
//
//  Created by Anastasia on 19.02.2021.
//
import UIKit

protocol AlertShowable: class {
  func showAlert(message text: String)
}

extension AlertShowable where Self: UIViewController {
  
  func showAlert(message text: String) {
    let alertController = UIAlertController(title: nil, message: text, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .cancel) { _ in }
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}
