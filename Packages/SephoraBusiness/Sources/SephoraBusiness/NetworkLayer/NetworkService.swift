//
//  NetworkService.swift
//
//
//  Created by Aymen Bokri on 10/06/2024.
//

import Foundation

public actor NetworkService: NetworkServiceProtocol {
    
    public init() {}
    
    /**
     Creates a URL request for the specified API endpoint.
     - Parameters:
     - endpoint: An object conforming to the APIEndpoint protocol that specifies the details of the request.
     
     - Returns: A URLRequest instance representing the network request, or nil if there's an issue with the URL construction.
     */
    private func makeURLRequest(for endpoint: APIEndpoint) -> URLRequest? {
        guard var urlComponents = URLComponents(string: endpoint.url) else {
            return nil
        }
        
        // Add query items to the URL for GET requests
        if endpoint.method == .get {
            urlComponents.queryItems = endpoint.parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        // Set request headers
        if let headers = endpoint.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Set request body for POST and PUT requests
        if let requestBody = endpoint.requestBody {
            urlRequest.httpBody = requestBody
        }
        
        return urlRequest
    }
    
    /**
     Fetches data from the specified API endpoint and decodes it into a Swift model.
     - Parameters:
     - endpoint: An object conforming to the APIEndpoint protocol that specifies the details of the request.
     - type: The type of the Swift model to decode the retrieved data into.
     
     - Returns: A Swift model instance containing the decoded data.
     
     - Throws: An error of type NetworkError if any network-related issue occurs, or other decoding errors.
     */
    public func fetchData<T: Decodable>(_ endpoint: APIEndpoint, type: T.Type) async throws -> T {
        guard let urlRequest = makeURLRequest(for: endpoint) else {
            throw NetworkError.badURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch let decodingError {
                throw NetworkError.decodingFailed(originalError: decodingError)
            }
            
        } catch let requestError {
            throw NetworkError.requestFailed(originalError: requestError)
        }
    }
}
