//
//  CustomBgView.swift
//  XPUIKit
//
//  Created by jamalping on 2024/3/16.
//

import Foundation

public class CustomBgView: BasePopoverBgView {
    ///弹窗背景的阴影偏移
//    public override var popShadowOffset: CGSize{
//        return CGSize.init(width: 10, height: 10)
//    }
    ///弹窗背景的阴影圆角
    public override var popShadowRadius: CGFloat{
        return 12
    }
    ///弹窗背景的阴影不透明度
    public override var popShadowOpacity: Float{
        return 0.2
    }
    ///弹窗背景的阴影颜色
    public override var popShadowColor: CGColor?{
        return UIColor.cyan.cgColor
    }
}
