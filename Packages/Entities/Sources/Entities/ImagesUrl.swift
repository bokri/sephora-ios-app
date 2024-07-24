//
//  ImagesUrl.swift
//  
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation

// Represents URLs for product images
public struct ImagesUrl: Decodable {
    
    // MARK: - Properties
    
    public let small: String // URL for the small image
    public let large: String? // URL for the large image (optional)
    
    // MARK: - Constructors
    
    // Initializes with small and optional large image URLs
    public init(small: String, large: String?) {
        self.small = small
        self.large = large
    }
}
