//
//  Presentable.swift
//  Movies_App
//
//  Created by Anastasia on 25.02.2021.
//

import UIKit

protocol Presentable {
  func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
  
  func toPresent() -> UIViewController? {
    return self
  }
}
