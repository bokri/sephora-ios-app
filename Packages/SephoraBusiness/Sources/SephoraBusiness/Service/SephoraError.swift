//
//  SephoraError.swift
//
//
//  Created by Aymen Bokri on 20/06/2024.
//

import Foundation

public enum SephoraError: Error {
    case productsError(originalError: Error)
}
