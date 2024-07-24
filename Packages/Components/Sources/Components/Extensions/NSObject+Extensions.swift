//
//  NSObject+Extensions.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation

extension NSObject {
    public class var className: String {
        return String(describing: self.classForCoder()) // Returns the name of the class as a string
    }
}
