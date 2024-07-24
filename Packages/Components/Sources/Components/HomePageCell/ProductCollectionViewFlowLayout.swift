//
//  ProductCollectionViewFlowLayout.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import UIKit

public class ProductCollectionViewFlowLayout: UICollectionViewFlowLayout {
    public override init() {
        super.init()
        setupLayout()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    private func setupLayout() {
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        scrollDirection = .vertical
        sectionInset = UIEdgeInsets(top: 0, left: Dimens.paddingM, bottom: 0, right: Dimens.paddingM)
    }

    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    public override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let availableWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing
        let itemWidth = availableWidth / 2
        itemSize = CGSize(width: itemWidth, height: 250)
    }
}
