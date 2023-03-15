//
//  HomeViewController.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import UIKit

class HomeViewController: UIViewController, Spawnable {
    
    static var storyboardName: String = R.storyboard.main.name
    
    weak var homeCoordinatorDelegate: HomeCoordinatorDelegate?
    
    
    static func spawn(homeCoordinatorDelegate: HomeCoordinatorDelegate?) -> HomeViewController {
        let controller = HomeViewController.spawn()
        controller.homeCoordinatorDelegate = homeCoordinatorDelegate
        return controller
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

