//
//  ScreenShieldViewDemoVC.swift
//  XPUIKit_Example
//
//  Created by lixiaoping on 2024/3/28.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import XPUIKit
import SnapKit

class ScreenShieldViewDemoVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(self.screenShieldView)
        self.screenShieldView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let label = UILabel.init()
        label.numberOfLines = 0
        label.text = "截屏时，需要隐藏的View装入到 screenShieldView 中就可以了"
        screenShieldView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(100)
        }
        
    }
    
    public lazy var screenShieldView = {
        let view = ScreenShieldView.create()
        view.isEnable = true
        return view
    }()
}
