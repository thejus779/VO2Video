//
//  AppCoordinator.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation
import UIKit

class AppCoordinator {
    
    let engine: Engine
    
    private var window: UIWindow
    private var tabController: VO2TabController?
    
    private var homeCoordinator: HomeCoordinator?
    
    var rootController: UINavigationController?
    
    init(engine: Engine, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.engine = engine
        
        // 1. Create and configure main window
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        //2. Create and configure main controller
        self.configureMainController()
        
    }
    
    // MARK: - Root controller
    func configureMainController() {
        let tabController = VO2TabController(engine: engine)
        window.rootViewController = tabController
        self.tabController = tabController
        self.configureTabController(tabController)
    }
    
    private func configureTabController(_ controller: VO2TabController) {
        var index = 0
        var vcs = [UIViewController]()
        while let tabIndex = TabIndex(rawValue: index) {
            let coordinator = self.configureCoordinator(tabIndex: tabIndex)
            coordinator.navigationController.tabBarItem = UITabBarItem(title: coordinator.title, image: coordinator.icon, selectedImage: nil)
            vcs.append(coordinator.navigationController)
            index += 1
        }
        controller.viewControllers = vcs
    }
    
    private func configureCoordinator(tabIndex: TabIndex) -> TabBarRepresentable & NavigatorPresentable {
        switch tabIndex {
        case .home:
            self.homeCoordinator = HomeCoordinator(engine: engine)
            return self.homeCoordinator!
        }
    }
}

enum TabIndex: Int {
    case home = 0
}
