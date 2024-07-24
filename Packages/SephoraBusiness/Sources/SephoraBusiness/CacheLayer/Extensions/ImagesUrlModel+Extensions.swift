//
//  ImagesUrl+Extensions.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import CoreData
import Entities

extension ImagesUrlModel {
    public func toEntity() -> ImagesUrl? {
        guard let small = small
        else {
            return nil
        }
        
        return ImagesUrl(small: small, large: large)
    }
}
