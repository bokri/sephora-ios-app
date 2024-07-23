//
//  LogDestination.swift
//  
//
//  Created by Aymen Bokri on 10/06/2024.
//

import Foundation

/**
 A protocol that defines the requirements for a custom log destination in the `Logger` utility.

 A custom log destination is responsible for handling log messages of different levels, including debugging, warnings, and errors, and specifying how these logs should be processed or displayed.

 Conform to this protocol to create custom log destinations for the `Logger` class. Implement the required methods for each log level and customize log handling based on your specific needs.

 - Important: Implement the methods of this protocol to define the behavior of a custom log destination when various log levels are encountered.

 # Logging Levels:
 - `debug`: For low-priority messages that help during debugging.
 - `warning`: For messages that may indicate potential issues.
 - `error`: For critical messages that require immediate attention.

 # See Also:
 - `Logger`: The logging utility that uses custom log destinations.
 - `ConsoleDestination`: A built-in log destination for logging to the console.

 For more information on creating custom log destinations and integrating them with the `Logger`, refer to the `Logger` class documentation or the README file.
 */
public protocol LogDestination: AnyObject {
    func debug(_ message: String)
    func warning(_ message: String)
    func error(_ error: Error, _ file: String, _ function: String, _ line: Int)
    func errorMessage(_ message: String, _ file: String, _ function: String, _ line: Int)
}
