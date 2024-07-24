//
//  ImagesUrl+Extensions.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import CoreData
import Entities

// MARK: - ImagesUrlModel Extension

extension ImagesUrlModel {
    
    /// Converts an `ImagesUrlModel` instance to an `ImagesUrl` entity.
    public func toEntity() -> ImagesUrl? {
        // Ensure that the `small` property is non-nil.
        guard let small = small else {
            // If `small` is nil, return nil.
            return nil
        }
        
        // Return an `ImagesUrl` entity initialized with `small` and optionally `large`.
        return ImagesUrl(small: small, large: large)
    }
}
