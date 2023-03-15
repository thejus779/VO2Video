//
//  MoviesGridCell.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import UIKit
import SDWebImage

class MoviesGridCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
    }
    
    func configure(viewModel: MoviesGridCellViewModel) {
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        posterImageView.sd_setImage(
            with: viewModel.posterImage,
            completed: nil
        )
    }

}
