//
//  ErrorViewDelegate.swift
//  
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation

public protocol ErrorViewDelegate: AnyObject {
    func errorButtonTouchUp() async // Handles the retry action when the button is tapped
}
