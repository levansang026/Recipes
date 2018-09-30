//
//  UIColor+Extensions.swift
//  Recipes
//
//  Created by Sang Le on 9/25/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit

extension UIColor {
    /// Init color from hex string
    ///
    /// - Parameter hex: A hex string, can start with or without #
    convenience init(hex: String) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        
        // Need 6 characters
        guard hex.count == 6 else {
            self.init(white: 1.0, alpha: 1.0)
            return
        }
        
        self.init(
            red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0,
            alpha: 1.0
        )
    }
}
