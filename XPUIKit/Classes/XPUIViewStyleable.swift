//
//  UIView+Extension.swift
//  XPUIKit
//
//  Created by jamalping on 2024/3/10.
//

import Foundation
import UIKit

public protocol Shadowable {
    func applyDropShadow(withOffset offset: CGSize,
                         opacity: Float,
                         radius: CGFloat,
                         color: UIColor)
}

public protocol Borderable {
    func addBorder(color: UIColor, borderWidth: CGFloat)
}

public protocol CornerRadiusable {
    func addCornerRadius(byRoundingCorners corners: CACornerMask, radius: CGFloat)
}

public protocol XPUIViewStyleable: Shadowable&Borderable&CornerRadiusable {}

extension XPUIViewStyleable where Self : UIView {
    
    public func addCornerRadius(byRoundingCorners corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = corners
        } else {
            // Fallback on earlier versions
        }
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    public func addBorder(color: UIColor, borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
    
    public func applyDropShadow(withOffset offset: CGSize,
                         opacity: Float,
                         radius: CGFloat,
                         color: UIColor) {
        layer.applyDropShadow(withOffset: offset,
                              opacity: opacity,
                              radius: radius,
                              color: color)
    }
    
    public func removeDropShadow() {
        layer.removeDropShadow()
    }
    
}

extension UIView: XPUIViewStyleable {}

extension CALayer {
    public func applyDropShadow(withOffset offset: CGSize,
                         opacity: Float,
                         radius: CGFloat,
                         color: UIColor) {
        shadowOffset = offset
        shadowOpacity = opacity
        shadowRadius = radius
        shadowColor = color.cgColor
        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
    }
    
    public func removeDropShadow() {
        shadowOffset = .zero
        shadowOpacity = 0
        shadowRadius = 0
        shadowColor = UIColor.clear.cgColor
        shouldRasterize = false
    }
}
