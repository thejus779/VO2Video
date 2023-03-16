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
    var viewModel: HomeViewModel!
    
    @IBOutlet private weak var moviesCollectionView: UICollectionView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var noDataLabel: UILabel!
    
    static func spawn(homeCoordinatorDelegate: HomeCoordinatorDelegate?, viewModel: HomeViewModel!) -> HomeViewController {
        
        let controller = HomeViewController.spawn()
        controller.homeCoordinatorDelegate = homeCoordinatorDelegate
        controller.viewModel = viewModel
        
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.registerObservers(observer: self)
        configureCollectionViewLayout()
        loadData()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .always
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    func configureCollectionViewLayout() {
        moviesCollectionView.collectionViewLayout = moviesCollectionView.gridLayout()
    }
    
    private func loadData() {
        loader.showLoader()
        noDataLabel.isHidden = true
        viewModel.getAllPopularMovies { [weak self] result in
            self?.loader.hideLoader()
            switch result {
            case .failure(let error):
                self?.presentAlert(message: error.localizedDescription, completion: nil)
            default: break
            }
            self?.reloadData()
        }
    }
    
    // Reload data
    private func reloadData() {
        loader.hideLoader()
        
        moviesCollectionView.isHidden = viewModel.allPopularMovies?.isEmpty ?? true
        moviesCollectionView.reloadData()

        noDataLabel.text = R.string.localizable.commonNoinfo()
        noDataLabel.isHidden = !(viewModel.allPopularMovies?.isEmpty ?? true)
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.allPopularMovies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesGridCell.kReuseIdentifier, for: indexPath
        ) as? MoviesGridCell,
                let movie = viewModel.allPopularMovies?[indexPath.item]
        else { fatalError("Developer error, no cell") }
        
        cell.configure(viewModel: MoviesGridCellViewModel(movie: movie))
        
        if let allPopularMovies = viewModel.allPopularMovies,
           indexPath.item == allPopularMovies.count - 1 {
            loadMore()
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = viewModel.allPopularMovies?[indexPath.row] {
            viewModel.getDetailsOf(movie: movie) { [weak self] (details, error) in
                if let details {
                    self?.homeCoordinatorDelegate?.showDetails(of: details)
                } else {
                    self?.presentAlert(message: error?.localizedDescription, completion: nil)
                }
            }
        }
       
    }
    private func loadMore() {
        viewModel.loadMorePopularMoviesIfNeeded { [weak self] error in
            if let error = error {
                self?.presentAlert(message: error.localizedDescription, completion: nil)
            }
            self?.reloadData()
        }
    }
}
extension HomeViewController: MoviesServiceObserver {
    func onFavouriteStateUpdated(movieId: Int, isFavourite: Bool) {
        viewModel.updateMovieFavouriteState(movieId: movieId, isFavourite: isFavourite)
        reloadData()
    }
}
