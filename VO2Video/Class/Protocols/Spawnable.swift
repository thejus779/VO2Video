//
//  Spawnable.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//
import Foundation
import UIKit

/// View controllers that can be instanciated from storyboard
protocol Spawnable {
        
    /// Instatiate a view controller
    static func spawn() -> Self
    
    /// Story board name
    static var storyboardName: String { get }
    
    /// If nil, will instantiate the initial view controller
    static var storyboardIdentifier: String? { get }

}

extension Spawnable where Self: UIViewController {
    static func spawn() -> Self {
        
        // Try a storyboard
        var controller: Self?
        
        if Bundle.main.path(forResource: storyboardName, ofType: "storyboardc") != nil {
            let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
            
            // If nil, will instantiate the initial view controller
            if let storyboardIdentifier = storyboardIdentifier {
                guard let instance = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
                    fatalError("Storyboard \(storyboardName) has no view controller with identifier \(storyboardIdentifier).")
                }
                controller = instance
            } else {
                guard let instance = storyboard.instantiateInitialViewController() as? Self else {
                    fatalError("Storyboard \(storyboardName) has no initial view controller defined.")
                }
                controller = instance
            }
        }
        
        // Simple initialization
        if let controller = controller {
            return controller
        } else {
            return self.init()
        }
    }
}
