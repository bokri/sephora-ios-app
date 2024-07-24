//
//  Brand.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation

// Defines a Brand with an id and a name
public struct Brand: Decodable {
    // MARK: - Properties
    
    public let id: String // Unique identifier for the brand
    public let name: String // Name of the brand
    
    // MARK: - Constructors
    
    // Initializes a Brand with the given id and name
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
