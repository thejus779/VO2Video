//
//  VO2TabController.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import UIKit

class VO2TabController: UITabBarController {
    
    var engine: Engine!
    
    init(engine: Engine) {
        self.engine = engine
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This is not how it is supposed to work")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = UITabBarItemAppearance()
        item.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        item.normal.iconColor = UIColor.lightGray
        item.selected.titleTextAttributes = [.foregroundColor: UIColor.systemRed]
        item.selected.iconColor = UIColor.systemRed
        

        
        let app = UITabBarAppearance()
        app.configureWithOpaqueBackground()
        app.backgroundColor = .black.withAlphaComponent(0.92)
        app.stackedLayoutAppearance = item
        app.inlineLayoutAppearance = item
        app.compactInlineLayoutAppearance = item
        
        tabBar.standardAppearance = app
        tabBar.scrollEdgeAppearance = app
        
    }
    
}
