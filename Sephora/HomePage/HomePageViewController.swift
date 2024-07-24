//
//  HomePageViewController.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import UIKit
import Entities
import SephoraBusiness
import Components
import RxSwift

class HomePageViewController: UIViewController {
    
    var viewModel: HomePageViewModel?
    
    // Success View
    private let collectionView: UICollectionView
    private let dataSource: ProductCollectionViewDataSource
    private let delegate: ProductCollectionViewDelegate
    private let flowLayout: ProductCollectionViewFlowLayout
    
    // Loading View
    
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    // Error View
    private let errorView: ErrorView
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: HomePageViewModel?) {
        self.viewModel = viewModel
        self.flowLayout = ProductCollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        self.dataSource = ProductCollectionViewDataSource(collectionView: self.collectionView)
        self.delegate = ProductCollectionViewDelegate()
        self.errorView = ErrorView()
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        Task {
            await fetchData()
        }
    }
    
    private func setupUI() {
        title = String(localized: .localizable(.homePageTitle))
        
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)
        view.addSubview(errorView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        collectionView.register(cellType: ProductCollectionViewCell.self)
        delegate.setupDelegate(delegate: self)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        errorView.setupDelegate(delegate: self)
        
        view.backgroundColor = UIColor(resource: .background)
        collectionView.backgroundColor = UIColor(resource: .background)
    }
    
    private func fetchData() async {
        await self.viewModel?.getProducts()
    }
    
    private func bindViewModel() {
        viewModel?.state
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                self?.handleStateChange(state)
            })
            .disposed(by: disposeBag)
        
        viewModel?.products
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] products in
                self?.dataSource.update(products: products)
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func handleStateChange(_ state: HomePageState) {
        switch state {
        case .loading:
            loadingIndicator.startAnimating()
            collectionView.isHidden = true
            errorView.isHidden = true
        case .success:
            loadingIndicator.stopAnimating()
            collectionView.isHidden = false
            errorView.isHidden = true
        case .error:
            loadingIndicator.stopAnimating()
            collectionView.isHidden = true
            errorView.isHidden = false
        }
    }
}

extension HomePageViewController: ErrorViewDelegate {
    func errorButtonTouchUp() async {
        await viewModel?.onErrorClicked()
    }
}

extension HomePageViewController: HomePageDelegate {
    func onCellClicked(index: Int) {
        viewModel?.onCellClicked(index: index)
    }
}
