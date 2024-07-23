//
//  Logger.swift
//  
//
//  Created by Aymen Bokri on 10/06/2024.
//

import Foundation
import os.log

/**
 A versatile logging utility that allows you to log messages with different levels of severity, send logs to various destinations, and customize log appearance.
 
 `Logger` provides a convenient way to log messages during development and debugging. It supports different log levels, including debug, warning, and error, and allows you to specify custom log destinations.
 
 # Example Usage:
 
 Logger.debug("This is a debug message.")
 Logger.warning("This is a warning message.")
 Logger.error("This is an error message.")
 
 
 - Important: By default, logs are only displayed in the console in DEBUG mode. You can add custom log destinations to extend log handling, such as saving logs to a file or sending logs to a remote server.
 
 # Custom Log Destinations:
 - To add a custom log destination, create a class that conforms to `LogDestination` and implement its methods for each log level.
 - Use `Logger.addDestination(_:)` to add a custom destination to the logger.
 
 # Logging Levels:
 - `debug`: For low-priority messages that help during debugging.
 - `warning`: For messages that may indicate potential issues.
 - `error`: For critical messages that require immediate attention.
 
 # See Also:
 - `LogDestination`: A protocol for custom log destinations.
 - `ConsoleDestination`: A built-in log destination for logging to the console.
 
 # Example:
 
 // Add a custom log destination (e.g., to save logs to a file)
 let fileLogger = FileLogDestination()
 Logger.addDestination(fileLogger)
 
 Logger.debug("This message goes to the console and the file.")
 
 For more information on custom log destinations, log formatting, and usage, refer to the documentation or the README file.
 
 - Note: In release mode, logs are not displayed unless custom log destinations are added.
 
 */
public enum Logger {
    private static var destinations: [LogDestination] = [ConsoleDestination()]

    private enum Level {
        case debug
        case warning
        case error

        var levelColor: String {
            #if DEBUG
            switch self {
            case .debug:
                return "🔵"
            case .warning:
                return "🔶"
            case .error:
                return "🔴"
            }
            #else
            return ""
            #endif
        }
    }

    public static func addDestination(_ destination: LogDestination) {
        if Logger.destinations.contains(where: { (lhs) -> Bool in
            String(describing: destination) == String(describing: lhs)
        }) {
            return
        }

        Logger.destinations.append(destination)
    }

    // MARK: Levels

    /// log something which help during debugging (low priority)
    public static func debug(_ message: String,
                          _ file: String = #fileID,
                          _ function: String = #function,
                          _ line: Int = #line) {
        let formattedString = Logger.formatString(level: .debug,
                                                  message: message,
                                                  file: file,
                                                  function: function,
                                                  line: line)

        for destination in Logger.destinations {
            destination.debug(formattedString)
        }
    }

    /// log something which may cause big trouble soon (high priority)
    public static func warning(_ message: String,
                            _ file: String = #fileID,
                            _ function: String = #function,
                            _ line: Int = #line) {
        let formattedString = Logger.formatString(level: .warning,
                                                  message: message,
                                                  file: file,
                                                  function: function,
                                                  line: line)

        for destination in Logger.destinations {
            destination.warning(formattedString)
        }
    }

    /// log something which will keep you awake at night (highest priority)
    public static func error(_ error: Error,
                          _ file: String = #fileID,
                          _ function: String = #function,
                          _ line: Int = #line) {
        for destination in Logger.destinations {
            destination.error(error, file, function, line)
        }
    }

    public static func error(_ errorMessage: String,
                          _ file: String = #fileID,
                          _ function: String = #function,
                          _ line: Int = #line) {
        let formattedString = Logger.formatString(level: .error,
                                                  message: errorMessage,
                                                  file: file,
                                                  function: function,
                                                  line: line)
        for destination in Logger.destinations {
            destination.errorMessage(formattedString, file, function, line)
        }
    }

    /// Format log parameters into a readable String
    private static func formatString(level: Logger.Level,
                                    message: String,
                                    file: String,
                                    function: String,
                                    line: Int) -> String {
        let fileName = ((file as NSString).lastPathComponent as NSString).deletingPathExtension
        let moduleName = (file as NSString).pathComponents.first ?? ""

        return "\(level.levelColor) [\(moduleName)] \(message) => \(fileName).\(function):\(line)".trimmingCharacters(in: .whitespaces)
    }
}
