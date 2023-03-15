//
//  UICollectionView+Extension.swift
//  VO2Video
//
//  Created by Thejus on 15/03/2023.
//

import UIKit

extension UICollectionView {
    func gridLayout(edgeInset: NSDirectionalEdgeInsets =  NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)) -> UICollectionViewCompositionalLayout {

        // Group with 2 items
        let doubleGroupItem1 = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)
            )
        )
        doubleGroupItem1.contentInsets = edgeInset
        
        let doubleGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.55)
            ),
            subitems: [doubleGroupItem1]
        )


        // Group with 3 item
        let tripleGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
        tripleGroupItem1.contentInsets = edgeInset

        let tripleGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.45)
            ),
            subitems: [tripleGroupItem1]
        )


        let mainGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(480)), subitems: [doubleGroup, tripleGroup])

        let section = NSCollectionLayoutSection(group: mainGroup)
        let gridLayout = UICollectionViewCompositionalLayout(section: section)
        return gridLayout
    }
}
