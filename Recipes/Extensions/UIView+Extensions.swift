//
//  UIView+Extensions.swift
//  Recipes
//
//  Created by Sang Le on 9/25/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Convenient method to add a list of subviews
    func addSubviews(_ views: [UIView]) {
        views.forEach({
            addSubview($0)
        })
    }
    
    /// Apply mask to round corners
    func round(corners: UIRectCorner) {
        let raddi = bounds.size.height / 2
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: raddi, height: raddi)
        )
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
    func addShadow(color: UIColor = .lightGray, opacity: Float = 0.7, radius: CGFloat = 5.0, offset: CGSize = CGSize(width: -1, height: 1)) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: -1, height: 1)
    }
}
