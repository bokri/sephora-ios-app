//
//  ImagesUrl+Extensions.swift
//  
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import Entities
import CoreData

extension ImagesUrl {
    public func toImagesUrlModel(context: CoreData.NSManagedObjectContext) -> ImagesUrlModel {
        let model = ImagesUrlModel(context: context)
        model.id = UUID()
        model.large = large
        model.small = small
        return model
    }
}
