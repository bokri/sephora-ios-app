//
//  BrandMode+Extensions.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import CoreData
import Entities

extension BrandModel {
    public func toEntity() -> Brand? {
        guard let id = id,
                let name = name
        else {
            return nil
        }
        
        return Brand(id: id, name: name)
    }
}
