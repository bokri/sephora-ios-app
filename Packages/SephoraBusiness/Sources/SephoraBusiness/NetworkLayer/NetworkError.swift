//
//  NetworkError.swift
//  
//
//  Created by Aymen Bokri on 10/06/2024.
//

import Foundation

/**
 An enumeration defining common network-related errors.

 The `NetworkError` enum provides a set of common network-related errors that can occur during network operations. It is used to represent specific error conditions when working with network requests and responses.

 - Note: This enum is typically used in conjunction with network operations to handle and propagate errors when issues arise during data retrieval or transmission.
*/
public enum NetworkError: LocalizedError {
    case badURL
    case decodingFailed(originalError: Error)
    case requestFailed(originalError: Error)
    
    public var errorDescription: String? {
        return switch self {
        case .badURL:
            "Bad endpoint or method type or URL"
        case .decodingFailed(let originalError):
            "Parsing Data has failed : \(originalError.localizedDescription)"
        case .requestFailed(let originalError):
            "Request has failed : \(originalError.localizedDescription)"
        }
    }
}
