//
//  UIActivityIndicator+Extensions.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import UIKit

extension UIActivityIndicatorView {
    /// Show loader and start spinning
    func showLoader() {
        isHidden = false
        startAnimating()
    }
    /// Hide loader
    func hideLoader() {
        hidesWhenStopped = true
        stopAnimating()
    }
}
