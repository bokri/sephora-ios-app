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
    
    // MARK: - Properties
    
    var viewModel: HomePageViewModel? // The view model providing data and business logic
    
    // Success View
    private let collectionView: UICollectionView // Collection view displaying products
    private let dataSource: ProductCollectionViewDataSource // Data source for the collection view
    private let delegate: ProductCollectionViewDelegate // Delegate for handling collection view interactions
    private let flowLayout: ProductCollectionViewFlowLayout // Layout for the collection view
    
    // Loading View
    private let loadingIndicator = UIActivityIndicatorView(style: .large) // Loading spinner
    
    // Error View
    private let errorView: ErrorView // View shown when an error occurs
    
    private let disposeBag = DisposeBag() // Bag for managing RxSwift disposables
    
    // MARK: - Constructor
    
    init(viewModel: HomePageViewModel?) {
        self.viewModel = viewModel
        self.flowLayout = ProductCollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        self.dataSource = ProductCollectionViewDataSource(collectionView: self.collectionView)
        self.delegate = ProductCollectionViewDelegate()
        self.errorView = ErrorView()
        super.init(nibName: nil, bundle: nil)
        
        setupUI() // Initialize UI components
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // Fatal error for unsupported initialization
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel() // Bind view model properties to UI components
        Task {
            await fetchData() // Fetch data asynchronously
        }
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = String(localized: .localizable(.homePageTitle)) // Set view controller title
        
        // Add subviews
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)
        view.addSubview(errorView)
        
        // Set up Auto Layout constraints
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
        
        // Register cell and set up delegate and data source
        collectionView.register(cellType: ProductCollectionViewCell.self)
        delegate.setupDelegate(delegate: self)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        errorView.setupDelegate(delegate: self)
        
        view.backgroundColor = UIColor(resource: .background) // Set background color
        collectionView.backgroundColor = UIColor(resource: .background) // Set collection view background color
    }
    
    private func fetchData() async {
        await self.viewModel?.getProducts() // Fetch products from view model
    }
    
    private func bindViewModel() {
        viewModel?.state
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                self?.handleStateChange(state) // Handle state changes
            })
            .disposed(by: disposeBag)
        
        viewModel?.products
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] products in
                self?.dataSource.update(products: products) // Update data source
                self?.collectionView.reloadData() // Reload collection view data
            })
            .disposed(by: disposeBag)
    }
    
    private func handleStateChange(_ state: HomePageState) {
        switch state {
        case .loading:
            loadingIndicator.startAnimating() // Show loading indicator
            collectionView.isHidden = true // Hide collection view
            errorView.isHidden = true // Hide error view
        case .success:
            loadingIndicator.stopAnimating() // Hide loading indicator
            collectionView.isHidden = false // Show collection view
            errorView.isHidden = true // Hide error view
        case .error:
            loadingIndicator.stopAnimating() // Hide loading indicator
            collectionView.isHidden = true // Hide collection view
            errorView.isHidden = false // Show error view
        }
    }
}

// MARK: - ErrorViewDelegate

extension HomePageViewController: ErrorViewDelegate {
    func errorButtonTouchUp() async {
        await viewModel?.onErrorClicked() // Retry fetching data on error button click
    }
}

// MARK: - HomePageDelegate

extension HomePageViewController: HomePageDelegate {
    func onCellClicked(index: Int) {
        viewModel?.onCellClicked(index: index) // Handle cell click event
    }
}
