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
    
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isMovingFromParent {
            viewModel?.coordinator?.backToListView()
        }
    }
}
