//
//  UIImageView+Extensions.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import UIKit

extension UIImageView {
    /**
     Asynchronously loads an image from a URL and sets it to the `UIImageView`.
     
     - Parameters:
     - urlString: The URL string of the image to load.
     - placeholder: An optional placeholder image to display while the actual image is loading. Defaults to `nil`.
     */
    public func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        // Set placeholder image if provided
        self.image = placeholder
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Image loading error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}
