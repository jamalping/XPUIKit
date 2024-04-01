//
//  XPScrollViewDemoVC.swift
//  XPUIKit_Example
//
//  Created by lixiaoping on 2024/4/1.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XPUIKit
import SnapKit

class XPScrollViewDemoVC: UIViewController {
    
    lazy  var vScrollView: XPScrollView =  {
        let scroll = XPScrollView.init(frame: .zero, scrollDirection: .horizontal)
        scroll.backgroundColor = .clear
//        scroll.scrollView.delegate = self
        scroll.scrollView.showsHorizontalScrollIndicator = false
        scroll.scrollView.showsVerticalScrollIndicator = false
        scroll.scrollView.bounces = false
        scroll.scrollView.scrollsToTop = true
        scroll.scrollView.isPagingEnabled = true
        scroll.scrollView.isScrollEnabled = true
        return scroll
    }()
    
    func createView() -> UIView {
        let view = UIView.init()
        view.backgroundColor = UIColor.randamColor()
        return view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.vScrollView)
        
        
        self.vScrollView.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.left.right.bottom.equalToSuperview()
        }
        
        
        let vSubviews: [UIView] = [1,2,3,4,5].enumerated().flatMap({ [weak self] (index, e)  in
            guard let self = self else { return nil}
            let v = self.createView()
            vScrollView.contentView.addSubview(v)
            v.snp.makeConstraints { make in
                make.width.height.top.bottom.equalTo(self.vScrollView)
                make.left.equalToSuperview().offset(UIScreen.main.bounds.width*CGFloat(index))
            }
            
            self.vScrollView.contentView.snp.remakeConstraints { make in
                make.edges.equalTo(self.vScrollView.scrollView)
                make.height.equalTo(self.vScrollView)
                make.right.equalTo(v)
            }
            return v
        })
        
        
        
        
    }
}
