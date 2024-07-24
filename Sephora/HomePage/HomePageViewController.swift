//
//  HomePageViewController.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import UIKit
import SephoraBusiness

class HomePageViewController: UIViewController {
    
    weak var coordinator: ListViewControllerDelegate?
    var viewModel: HomePageViewModel?
    
    let button = UIButton()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Go to Details", for: .normal)
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: HomePageViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func onClick() {
//        coordinator?.goToDetailView()
        Task {
            let sephoraService = SephoraService()
            let products = try? await sephoraService.getProducts()
            print("Products \(products?.count)")
        }
        
    }
}
