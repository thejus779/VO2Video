//
//  HideBackTitleNavigationController.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation
import UIKit

/// Native UINavigationController which removes the back bar button text
class HideBackTitleNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let backItem = UIBarButtonItem()
        backItem.title = " "
        viewControllers.last?.navigationItem.backBarButtonItem = backItem
        super.pushViewController(viewController, animated: animated)
    }
}
