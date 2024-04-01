//
//  DefaultPopoVC.swift
//  XPUIKit
//
//  Created by jamalping on 2024/3/16.
//

import Foundation

open class PopDefaultConfig {
    public static let shared = PopDefaultConfig()
    ///弹窗背景的阴影偏移
    public var shadowOffset:CGSize = CGSize.init(width: 0, height: 4)
    ///弹窗背景的阴影圆角
    public var shadowRadius:CGFloat = 4
    ///弹窗背景的阴影不透明度
    public var shadowOpacity:Float = 0.2
    ///弹窗背景的阴影颜色
    public var shadowColor:UIColor = .gray
    ///弹窗边框宽度
    public  var borderWidth: CGFloat = 0
    ///弹窗边框颜色
    public var borderColor: UIColor = .white
    ///弹窗的圆角
    public var cornerRadius: CGFloat = 0
    ///弹窗要设置圆角的角
    public var maskedCorners:CACornerMask = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    private init(){}
}

open class DefaultPopoverBgView: BasePopoverBgView {
    ///弹窗背景的阴影偏移
    public override var popShadowOffset: CGSize{
        return PopDefaultConfig.shared.shadowOffset
    }
    ///弹窗背景的阴影圆角
    public override var popShadowRadius: CGFloat{
        return PopDefaultConfig.shared.shadowRadius
    }
    ///弹窗背景的阴影不透明度
    public override var popShadowOpacity: Float{
        return PopDefaultConfig.shared.shadowOpacity
    }
    ///弹窗背景的阴影颜色
    public override var popShadowColor: CGColor?{
        return PopDefaultConfig.shared.shadowColor.cgColor
    }
}

open class DefaultPopoVC: XPBasePopoverVC<DefaultPopoverBgView> {
    ///弹窗边框宽度
    public override var popBorderWidth: CGFloat{
        return PopDefaultConfig.shared.borderWidth
    }
    ///弹窗边框颜色
    public override var popBorderColor: CGColor?{
        return PopDefaultConfig.shared.borderColor.cgColor
    }
    ///弹窗的圆角
    public override var popCornerRadius: CGFloat{
        return PopDefaultConfig.shared.cornerRadius
    }
    ///弹窗要设置圆角的角
    @available(iOS 11.0, *)
    public override var popMaskedCorners: CACornerMask{
        return PopDefaultConfig.shared.maskedCorners
    }
}
