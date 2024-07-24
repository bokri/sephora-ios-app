//
//  ImagesUrl.swift
//  
//
//  Created by Aymen Bokri on 23/07/2024.
//

import Foundation

public struct ImagesUrl: Decodable {
    public let small: String
    public let large: String?
    
    public init(small: String, large: String?) {
        self.small = small
        self.large = large
    }
}
