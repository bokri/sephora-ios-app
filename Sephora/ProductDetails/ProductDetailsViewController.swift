//
//  ProductDetailsViewController.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import UIKit
import Components

class ProductDetailsViewController: UIViewController {
    
    var viewModel: ProductDetailsViewModel?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let productImageView = UIImageView()
    private let titleLabel = UILabel()
    private let brandLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            viewModel?.coordinator?.backToListView()
        }
    }
    
    private func setupUI() {
        title = viewModel?.productItem.productName
        view.backgroundColor = .systemBackground
        
        // Add scroll view and content view
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews to content view
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(brandLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        
        // Configure subviews
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        
        titleLabel.font = Fonts.boldXL
        titleLabel.numberOfLines = 0
        
        brandLabel.font = Fonts.regularL
        brandLabel.textColor = .gray
        brandLabel.numberOfLines = 0
        
        descriptionLabel.font = Fonts.regularM
        descriptionLabel.numberOfLines = 0
        
        priceLabel.font = Fonts.boldL
        
        // Layout constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Dimens.paddingL),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.paddingL),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.paddingL),
            productImageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: Dimens.paddingL),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.paddingL),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.paddingL),
            
            brandLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Dimens.paddingM),
            brandLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.paddingL),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.paddingL),
            
            descriptionLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: Dimens.paddingM),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.paddingL),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.paddingL),
            
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Dimens.paddingL),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.paddingL),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.paddingL),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Dimens.paddingL)
        ])
    }
    
    private func configureUI() {
        guard let product = viewModel?.productItem else { return }
        titleLabel.text = product.productName
        brandLabel.text = product.cBrand.name
        descriptionLabel.text = product.description
        priceLabel.text = "\(product.price) €"
        
        if let imageUrlString = product.imagesUrl?.small, let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.productImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
