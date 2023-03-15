//
//  HomeCoordinator.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation
import UIKit

protocol HomeCoordinatorDelegate: AnyObject {}

class HomeCoordinator: NSObject, NavigatorPresentable {
    
    var navigationController: UINavigationController
    let engine: Engine
    

    init(engine: Engine) {
        self.engine = engine
        navigationController = HideBackTitleNavigationController()
        super.init()
                
        // View Controller
        
        let homeVC = HomeViewController.spawn(
            homeCoordinatorDelegate: self, viewModel: HomeViewModel(engine: engine)
        )
        homeVC.title = R.string.localizable.homeTitle()
        navigationController.setViewControllers([homeVC], animated: false)
    }
}

extension HomeCoordinator: HomeCoordinatorDelegate {
}

extension HomeCoordinator: TabBarRepresentable {
    var icon: UIImage {
        UIImage(systemName: "video.circle")!
    }
    var title: String {
        return R.string.localizable.homeTabTitle()
    }
}
