//
//  HomePageDelegate.swift
//  Sephora
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation

/// Delegate protocol for handling interactions from the HomePage view.
protocol HomePageDelegate: AnyObject {
    
    /// Notifies the delegate that a cell has been clicked.
    /// - Parameter index: The index of the clicked cell in the list.
    func onCellClicked(index: Int)
}
