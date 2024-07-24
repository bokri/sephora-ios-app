//
//  SephoraError.swift
//
//
//  Created by Aymen Bokri on 20/06/2024.
//

import Foundation

public enum SephoraError: LocalizedError {
    case productsError(originalError: Error)
    case dataBaseError(originalError: Error)
    
    /// Provides a localized description for the error.
    public var errorDescription: String? {
        switch self {
        case .productsError(let originalError):
            return "An error occurred: \(originalError.localizedDescription)"
        case .dataBaseError(let originalError):
            return "An error occurred while performing a database operation: \(originalError.localizedDescription)"
        }
    }
}
