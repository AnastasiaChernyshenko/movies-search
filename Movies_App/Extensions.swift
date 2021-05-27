//
//  Extensions.swift
//  Movies_App
//
//  Created by Anastasia on 14.02.2021.
//

import Foundation
import UIKit

extension String{
    func urlEncode() -> String{
        return self.replacingOccurrences(of: " ", with: "%20")
    }
}

extension UIImageView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
    func loadURL(_ url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


extension UIView {
    func dropShadow() {
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
    }
}

extension Date{
    func toString(_ format: String = "dd.MM.yyyy") -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
