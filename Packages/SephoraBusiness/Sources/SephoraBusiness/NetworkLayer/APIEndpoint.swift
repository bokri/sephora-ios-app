//
//  APIEndpoint.swift
//
//
//  Created by Aymen Bokri on 10/06/2024.
//

import Foundation

/**
 A protocol defining the structure of an API endpoint.

 The `APIEndpoint` protocol provides a blueprint for constructing API endpoints used to make network requests. It defines properties that encapsulate key information needed for network requests, including the URL, HTTP method, parameters, request body, and headers.

 - Important: Conform to this protocol to define custom API endpoints for network requests.

 - SeeAlso: `HTTPMethod`
 */
public protocol APIEndpoint {
    /// The URL of the API endpoint.
    var url: String { get }

    /// The HTTP method used for the network request.
    var method: HTTPMethod { get }

    /// The parameters to include in the network request.
    var parameters: [String: Any] { get }

    /// The request body data to send with the network request, if applicable.
    var requestBody: Data? { get }

    /// The headers to include in the network request, if any.
    var headers: [String: String]? { get }
}
