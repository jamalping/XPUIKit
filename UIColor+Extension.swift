//
//  UIColor+Extension.swift
//  XPUIKit
//
//  Created by lixiaoping on 2024/4/1.
//

import Foundation

public extension UIColor {
    /// 获取随机颜色
    /// - Returns: 随机颜色
    class func randamColor() -> UIColor{
        let R = CGFloat(arc4random_uniform(255))/255.0
        let G = CGFloat(arc4random_uniform(255))/255.0
        let B = CGFloat(arc4random_uniform(255))/255.0
        return UIColor.init(red: R, green: G, blue: B, alpha: 1)
    }
    
}
