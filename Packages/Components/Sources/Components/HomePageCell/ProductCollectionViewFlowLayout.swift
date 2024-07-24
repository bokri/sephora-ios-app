//
//  ProductCollectionViewFlowLayout.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import UIKit

public class ProductCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Constructors
    
    // Initializes with default layout settings
    public override init() {
        super.init()
        setupLayout()
    }

    // Initializes with coder (for storyboard or XIB support)
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    // MARK: - Private Methods

    // Configures layout properties
    private func setupLayout() {
        minimumLineSpacing = Dimens.paddingS // Space between rows
        minimumInteritemSpacing = Dimens.paddingS // Space between items in a row
        scrollDirection = .vertical // Vertical scrolling
        sectionInset = UIEdgeInsets(top: 0, left: Dimens.paddingM, bottom: 0, right: Dimens.paddingM) // Insets for section
    }
    
    // MARK: - UICollectionViewFlowLayout

    // Indicates that the layout should be invalidated for bounds changes
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    // Prepares layout by setting item size
    public override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        // Calculate item width based on available space
        let availableWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing
        guard availableWidth > 0 else { return }
        let itemWidth = availableWidth / 2
        itemSize = CGSize(width: itemWidth, height: 250) // Set item size
    }
}
