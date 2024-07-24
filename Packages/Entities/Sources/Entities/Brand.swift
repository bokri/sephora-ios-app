//
//  Brand.swift
//
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation

public struct Brand: Decodable {
    public let id: String
    public let name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
