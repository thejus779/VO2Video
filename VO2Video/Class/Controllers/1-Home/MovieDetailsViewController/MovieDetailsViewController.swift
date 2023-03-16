//
//  MovieDetailsViewController.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController, Spawnable {
    
    static var storyboardName: String = R.storyboard.main.name
    
    @IBOutlet private weak var addToFavouriteButton: UIButton!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var ratingContainer: UIView!
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var mainStackView: UIStackView!
    
    var viewModel: MovieDetailsViewModel!
    var ratingsView = RatingsView.fromNib()
    
    static func spawn(viewModel: MovieDetailsViewModel) -> MovieDetailsViewController {
        let controller = MovieDetailsViewController.spawn()
        controller.viewModel = viewModel
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
        
        updateFavouriteButton()
        closeButton.setImage(
            UIImage(systemName: "xmark")!,
            for: .normal
        )
        
        configureRatingsContainer()
        
        // Year configuration
        if let releaseDateString = viewModel.releaseDateString {
            let dateView = AccessoryView.fromNib()
            dateView.configure(displayType: .date, title: releaseDateString)
            mainStackView.addArrangedSubview(dateView)
        }
        
        // Duration config
        if let runtime = viewModel.runtime {
            let runTimeView = AccessoryView.fromNib()
            runTimeView.configure(displayType: .duration, title: runtime)
            mainStackView.addArrangedSubview(runTimeView)
        }
    }
    
    private func configureRatingsContainer() {
        ratingContainer.addSubview(ratingsView)
        NSLayoutConstraint.activate([
            ratingsView.leadingAnchor.constraint(equalTo: ratingContainer.leadingAnchor),
            ratingsView.topAnchor.constraint(equalTo: ratingContainer.topAnchor),
            ratingsView.bottomAnchor.constraint(equalTo: ratingContainer.bottomAnchor)
        ])
        ratingsView.configure(ratingIn10: viewModel.rating ?? 0)
    }
    
    private func updateFavouriteButton() {
        addToFavouriteButton.setImage(
            UIImage(systemName: viewModel.isFavourite ? "star.fill" : "star")! ,
            for: .normal
        )
    }
    @IBAction func didTapAddToFavourite(_ sender: Any) {
        viewModel.updateFavouriteState()
        updateFavouriteButton()
    }
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
}
