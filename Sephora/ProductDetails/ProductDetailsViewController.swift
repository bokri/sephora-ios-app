//
//  ProductDetailsViewController.swift
//  Sephora
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation
import UIKit

class ProductDetailsViewController: UIViewController {
    
    var viewModel: ProductDetailsViewModel?
    weak var coordinator: ProductDetailViewControllerDelegate?
    
    func configure(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isMovingFromParent {
            coordinator?.backToListView()
        }
    }
    
}
