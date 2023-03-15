//
//  AccessoryView.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import UIKit

class AccessoryView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static func fromNib() -> AccessoryView {
        let view = Bundle.main.loadNibNamed(
                Self.kReuseIdentifier,
                owner: nil,
                options: nil
        )?.first as? AccessoryView
        return view!
    }
    
    func configure(displayType: AccessoryDisplayType, title: String) {
        titleLabel.text = title
        imageView.image = displayType.image
    }
}

enum AccessoryDisplayType {
    case date
    case duration
}
extension AccessoryDisplayType {
    var image: UIImage {
        switch self {
        case .date:
            return UIImage(systemName: "calendar")!
        case .duration:
            return UIImage(systemName: "clock.circle.fill")!
        }
    }
}
