//
//  Representables.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import UIKit

protocol NavigatorPresentable {
    var navigationController: UINavigationController { get }
}

protocol TabBarRepresentable {
    var icon: UIImage { get }
    var title: String { get }
}
