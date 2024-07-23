//
//  HTTPMethod.swift
//
//
//  Created by Aymen Bokri on 10/06/2024.
//

import Foundation

/**
 An enumeration defining HTTP methods for network requests.

 The `HTTPMethod` enum provides a set of HTTP methods commonly used in network requests, including GET, POST, and PUT. It serves as a convenient way to specify the HTTP method for a network request.

 - Important: Use this enum to set the HTTP method for network requests.
*/
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    // Add other methods as needed
}
