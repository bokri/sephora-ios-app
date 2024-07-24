//
//  MockLogDestination.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import XCTest
@testable import SephoraBusiness

final class MockLogDestination: LogDestination {
    var debugMessages: [String] = []
    var warningMessages: [String] = []
    var errorMessages: [(error: Error, file: String, function: String, line: Int)] = []
    var errorMessageStrings: [(message: String, file: String, function: String, line: Int)] = []

    func debug(_ message: String) {
        debugMessages.append(message)
    }

    func warning(_ message: String) {
        warningMessages.append(message)
    }

    func error(_ error: Error, _ file: String, _ function: String, _ line: Int) {
        errorMessages.append((error, file, function, line))
    }

    func errorMessage(_ message: String, _ file: String, _ function: String, _ line: Int) {
        errorMessageStrings.append((message, file, function, line))
    }
}
