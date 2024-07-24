//
//  SephoraApiEndpoint.swift
//
//
//  Created by Aymen Bokri on 12/06/2024.
//

import Foundation

public enum SephoraApiEndpoint: APIEndpoint {
    /// The base URL for Sephora API requests.
    private static let baseURL = "https://sephoraios.github.io"
    
    case getProducts

    /// The path specific to each API endpoint.
    private var path: String {
        return switch self {
        case .getProducts:
            "/items.json"
        }
    }
    
    /// A dictionary of parameters to be included in the request.
    public var parameters: [String : Any] {
        let parameters: [String: Any] = [:]
        
        switch self {
        case .getProducts:
            break
        }
        return parameters
    }
    
    /// The HTTP method for this endpoint (e.g., GET, POST, PUT, etc.).
    public var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    /// The complete URL for this endpoint, constructed from the base URL and endpoint-specific path.
    public var url: String {
        return SephoraApiEndpoint.baseURL + self.path
    }
    
    /// The request body (if any) for this endpoint. Returns nil for GET requests.
    public var requestBody: Data? {
        return nil
    }
    
    /// The request headers (if any) for this endpoint. Returns nil for no specific headers.
    public var headers: [String : String]? {
        return nil
    }
}
