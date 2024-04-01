//
//  XPBaseScrollView.swift
//  MLBaseKit
//
//  Created by lixiaoping on 2023/3/6.
//

import UIKit

/// 滚动方向
public enum ScrollDirection {
    /// 垂直
    case vertical
    /// 水平
    case horizontal
}

public class XPScrollView: UIView {
    
    public let scrollView = UIScrollView()
    
    public var contentView: UIView {
        get {
            return self.containerView
        }
    }
    
    public var scrollDirection: ScrollDirection {
        return _scrollDirection
    }
    var _scrollDirection: ScrollDirection = .vertical
    
    let containerView: UIView = UIView()

    public init(frame: CGRect, scrollDirection: ScrollDirection = .vertical) {

        super.init(frame: frame)

        self._scrollDirection = .vertical
        
        addSubview(scrollView)
        
        scrollView.bounces = false
        
        scrollView.addSubview(containerView)
        
        if self._scrollDirection == .vertical {
            scrollView.snp.makeConstraints { (make) -> Void in
                
                make.centerX.equalTo(snp.centerX)
                
                make.top.bottom.equalTo(self)
                
                make.width.equalTo(self)
                
            }
            containerView.snp.makeConstraints { (make) -> Void in
                
                make.edges.equalTo(scrollView)
                
                make.height.equalTo(UIScreen.main.bounds.width)
                
            }
        }else {
            
            /**
             *  对scrollView添加约束
             *  Add constraints to scrollView
             */
            scrollView.snp.makeConstraints { (make) -> Void in
                
                make.centerY.equalTo(snp.centerY)
                
                make.left.right.equalTo(self)
                
                make.height.equalTo(frame.height)
                
            }
            
            /**
             *  对containerView添加约束，接下来只要确定containerView的宽度即可
             *  Add constraints to containerView, the only thing we will do
             *  is to define the width of containerView
             */
            containerView.snp.makeConstraints { (make) -> Void in
                
                make.edges.equalTo(scrollView)
                
                make.width.equalTo(UIScreen.main.bounds.width)
                
            }
        }
        
    }
    
    func configPage() {
        
        addSubview(scrollView)
        
        scrollView.bounces = false
        
        scrollView.addSubview(containerView)
                
        /**
         *  对scrollView添加约束
         *  Add constraints to scrollView
         */
        scrollView.snp.makeConstraints { (make) -> Void in
            
            make.centerY.equalTo(snp.centerY)
            
            make.left.right.equalTo(self)
            
            make.height.equalTo(1000)
            
        }
        
//        /**
//         *  对containerView添加约束，接下来只要确定containerView的宽度即可
//         *  Add constraints to containerView, the only thing we will do
//         *  is to define the width of containerView
//         */
//        containerView.snp.makeConstraints { (make) -> Void in
//
//            make.edges.equalTo(scrollView)
//
//            make.width.equalTo(screenW)
//
//            make.height.equalTo(self)
//
//        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
