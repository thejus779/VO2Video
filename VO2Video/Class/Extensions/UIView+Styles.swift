//
//  UIView+Styles.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import UIKit

extension UIView {
    
    func blurred() {
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        
        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }
}
