//
//  BrandMode+Extensions.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import CoreData
import Entities

// MARK: - BrandModel Extension

extension BrandModel {
    
    /// Converts a `BrandModel` instance to a `Brand` entity.
    public func toEntity() -> Brand? {
        // Ensure that both `id` and `name` properties are non-nil.
        guard let id = id,
              let name = name
        else {
            // If either property is nil, return nil.
            return nil
        }
        
        // Return a `Brand` entity initialized with `id` and `name`.
        return Brand(id: id, name: name)
    }
}
