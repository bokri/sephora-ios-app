//
//  NetworkServiceProtocol.swift
//
//
//  Created by Aymen Bokri on 10/06/2024.
//

import Foundation

public protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(_ endpoint: APIEndpoint, type: T.Type) async throws -> T
}
