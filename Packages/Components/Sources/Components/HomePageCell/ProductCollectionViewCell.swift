//
//  ProductCollectionViewCell.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCollectionViewCell"

    private let productImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.backgroundColor = UIColor(resource: .background)
        contentView.layer.cornerRadius = Dimens.cornerRadius
        contentView.layer.shadowColor = UIColor(resource: .background).cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = Dimens.shadowRadius

        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)

        productImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 150),

            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: Dimens.paddingS),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.paddingS),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.paddingS),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Dimens.paddingS),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.paddingS),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.paddingS),

            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Dimens.paddingS),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.paddingS),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.paddingS),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Dimens.paddingS)
        ])
    }

    func configure(with product: Product) {
        titleLabel.text = product.product_name
        descriptionLabel.text = product.description
        priceLabel.text = "\(product.price) €"
        titleLabel.font = UIFont.boldSystemFont
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = UIColor(resource: .foreground)
        priceLabel.font = UIFont.systemFont
        priceLabel.textColor = UIColor(resource: .foreground)

        // Load the image
        if let url = URL(string: product.images_url.small) {
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
