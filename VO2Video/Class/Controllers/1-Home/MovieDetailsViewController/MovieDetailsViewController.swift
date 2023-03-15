//
//  MovieDetailsViewController.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import UIKit
import SDWebImage

protocol MovieDetailsViewControllerDelegate: AnyObject {
    func movieDetailsViewController(_ controller: MovieDetailsViewController, addedToFavourite movieDetails: MovieDetails)
}
class MovieDetailsViewController: UIViewController, Spawnable {
    
    static var storyboardName: String = R.storyboard.main.name
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingContainer: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var viewModel: MovieDetailsViewModel!
    weak var delegate: MovieDetailsViewControllerDelegate?
    
    static func spawn(viewModel: MovieDetailsViewModel, delegate: MovieDetailsViewControllerDelegate?) -> MovieDetailsViewController {
        let controller = MovieDetailsViewController.spawn()
        controller.viewModel = viewModel
        controller.delegate = delegate
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        
        posterImageView.sd_setImage(
            with: viewModel.posterImage,
            completed: { [weak self] image,_,_,_ in
                self?.backgroundImage.image = image
                self?.backgroundImage.blurred()
            }
        )
        
    }
    @IBAction func didTapAddToFavourite(_ sender: Any) {
        delegate?.movieDetailsViewController(self, addedToFavourite: viewModel.movie)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
}
