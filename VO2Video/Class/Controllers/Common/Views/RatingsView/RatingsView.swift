//
//  RatingsView.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import UIKit

class RatingsView: UIView {
    static func fromNib() -> RatingsView {
        let view = Bundle.main.loadNibNamed(
                Self.kReuseIdentifier,
                owner: nil,
                options: nil
        )?.first as? RatingsView
        return view!
    }
    
    @IBOutlet weak var stackView: UIStackView!
    
    func configure(ratingIn10: Double) {
        let ratingIn5 = ratingIn10 / 2


        if ratingIn5.truncatingRemainder(dividingBy: 1) == 0 {
            for _ in 1...Int(ratingIn5) {
                stackView.addArrangedSubview(starImageViewFilled())
            }
            if ratingIn5 < 5 {
                for _ in Int(ratingIn5 + 1)...5 {
                    stackView.addArrangedSubview(starImageViewEmpty())
                }
            }
            
        } else {
            // 0.5
            if ratingIn5 < 1 {
                stackView.addArrangedSubview(starImageViewHalf())
                for _ in 2...5 {
                    stackView.addArrangedSubview(starImageViewEmpty())
                }
            } else {
                // 2.5
                for _ in 1...Int(ratingIn5) {
                    stackView.addArrangedSubview(starImageViewFilled())
                }
                stackView.addArrangedSubview(starImageViewHalf())
                
                if Int(ratingIn5) < 4 {
                    for _ in Int(ratingIn5 + 2)...5 {
                        stackView.addArrangedSubview(starImageViewEmpty())
                    }
                }
            }
            
        }
    }
    func starImageViewHalf() -> UIImageView {
        imageView(imageName: "star.fill.left")
    }
    func starImageViewFilled() -> UIImageView {
        imageView(imageName: "star.fill")
    }
    func starImageViewEmpty() -> UIImageView {
        imageView(imageName: "star")
    }
    func imageView(imageName: String) -> UIImageView {
        let starImageViewEmpty = UIImageView(image: UIImage(systemName: imageName))
        starImageViewEmpty.tintColor = UIColor.systemRed
        return starImageViewEmpty
    }
}
