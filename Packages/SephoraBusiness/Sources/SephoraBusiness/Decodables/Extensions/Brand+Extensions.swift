//
//  Brand+Extensions.swift
//  
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import Entities
import CoreData

extension Brand {
    /// Converts `Brand` to `BrandModel` for Core Data storage.
    public func toBrandModel(context: CoreData.NSManagedObjectContext) -> BrandModel {
        let model = BrandModel(context: context)
        model.id = id
        model.name = name
        return model
    }
}
