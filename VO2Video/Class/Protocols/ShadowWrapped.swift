//
//  ShadowWrapped.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import UIKit

protocol ShadowWrapped: AnyObject {
    var containerView: UIView! { get }
}
extension ShadowWrapped {
    func configureShadowedContainer() {
        containerView.layer.cornerRadius = 6
        containerView.shadowStyle = .medium
    }
}
