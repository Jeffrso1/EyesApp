//
//  StretchyLayout.swift
//  Eyes
//
//  Created by Lucas Frazão on 03/11/20.
//

import UIKit

class DIYLayout: UICollectionViewFlowLayout {
    
    let idealCellWidth: CGFloat = 100
        let margin: CGFloat = 10

        override init() {
            super.init()

            sectionInsetReference = .fromLayoutMargins
            sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
            headerReferenceSize = CGSize(width: 0, height: 80)
            sectionHeadersPinToVisibleBounds = false
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func prepare() {
            super.prepare()

            guard let collectionView = collectionView else { return }
            let availableWidth = collectionView.frame.width - collectionView.safeAreaInsets.left - collectionView.safeAreaInsets.right - sectionInset.left - sectionInset.right
            let idealNumberOfCells = (availableWidth + minimumInteritemSpacing) / (idealCellWidth + minimumInteritemSpacing)
            let numberOfCells = idealNumberOfCells.rounded(.down)
            let cellWidth = (availableWidth + minimumInteritemSpacing) / numberOfCells - minimumInteritemSpacing
            itemSize = CGSize(width: cellWidth, height: cellWidth)
        }

        override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
            return true
        }

        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            guard let collectionView = collectionView else { return nil }
            guard let rectAttributes = super.layoutAttributesForElements(in: rect) else { return nil }

            let offsetY = collectionView.contentOffset.y + collectionView.safeAreaInsets.top
            if let firstHeader = rectAttributes.first(where: { $0.representedElementKind == UICollectionView.elementKindSectionHeader && offsetY < 0}) {
                let origin = CGPoint(x: firstHeader.frame.origin.x, y: firstHeader.frame.minY - offsetY.magnitude)
                let size = CGSize(width: firstHeader.frame.width, height: max(0, headerReferenceSize.height + offsetY.magnitude))
                firstHeader.frame = CGRect(origin: origin, size: size)
            }

            return rectAttributes
        }
    
    
    
}
