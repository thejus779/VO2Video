//
//  HomeCoordinator.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import Foundation
import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func showDetails(of movie: MovieDetails)
}

class HomeCoordinator: NSObject, NavigatorPresentable {
    
    var navigationController: UINavigationController
    let engine: Engine
    var homeViewController: HomeViewController?

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
    func showDetails(of movie: MovieDetails) {
        let movieDetailsViewController = MovieDetailsViewController.spawn(
            viewModel: MovieDetailsViewModel(movie: movie), delegate: self
        )
        navigationController.present(movieDetailsViewController, animated: true)
    }
}

extension HomeCoordinator: MovieDetailsViewControllerDelegate {
    func movieDetailsViewController(_ controller: MovieDetailsViewController, addedToFavourite movieDetails: MovieDetails) {
        homeViewController?.viewModel.addMovieToFavourite(movieDetails: movieDetails)
        homeViewController?.reloadData()
    }
}
extension HomeCoordinator: TabBarRepresentable {
    var icon: UIImage {
        UIImage(systemName: "video.circle")!
    }
    var title: String {
        return R.string.localizable.homeTabTitle()
    }
}
