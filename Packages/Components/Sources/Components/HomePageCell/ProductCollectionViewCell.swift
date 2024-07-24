//
//  ProductCollectionViewCell.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import UIKit
import Entities

public class ProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let productImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let brandLabel = UILabel()
    
    // MARK: - Constructors

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods

    // Sets up UI elements and constraints
    private func setupUI() {
        contentView.backgroundColor = UIColor(resource: .background)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.shadowColor = UIColor(resource: .foreground).cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.masksToBounds = false

        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 10
        productImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(brandLabel)

        productImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false

        // Layout constraints for subviews
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 150),

            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: Dimens.paddingS),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.paddingS),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.paddingS),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Dimens.paddingXS),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.paddingS),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.paddingS),
            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),

            brandLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Dimens.paddingXS),
            brandLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.paddingS),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.paddingS),
            brandLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Dimens.paddingS)
        ])
    }
    
    // MARK: - Public Methods

    // Configures cell with product details
    public func configure(with product: ProductItem) {
        titleLabel.text = product.productName
        priceLabel.text = "\(product.price) €"
        brandLabel.text = product.cBrand.name

        titleLabel.font = Fonts.boldM
        priceLabel.font = Fonts.regularM
        priceLabel.textAlignment = .center
        priceLabel.textColor = UIColor(resource: .foreground)
        brandLabel.font = Fonts.regularS
        brandLabel.textColor = UIColor(resource: .foreground)

        // Load and set product image
        if let small = product.imagesUrl?.small, let url = URL(string: small) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.productImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}
