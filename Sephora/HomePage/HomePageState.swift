//
//  HomePageState.swift
//  Sephora
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation

/// Enum representing the various states of the HomePage view model.
enum HomePageState {
    /// The state when data is being loaded.
    case loading
    
    /// The state when data has been successfully loaded.
    case success
    
    /// The state when an error has occurred during data loading.
    case error
}
