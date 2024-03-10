//
//  UIViewStyleVC.swift
//  XPUIKit_Example
//
//  Created by jamalping on 2024/3/10.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import SnapKit
import XPUIKit

class UIViewStyleVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "UIViewStyle(shadow,cornerRadius、Border)"
        
        view.backgroundColor = .white
        
        self.view.addSubview(self.view5)
        self.view5.addSubview(self.view1)
        self.view1.addSubview(self.view2)
        
        self.layout()
    }
    
    func layout() {
        self.view1.snp.makeConstraints { make in
            make.center.equalToSuperview()
            
            make.width.height.equalTo(100)
        }
        
        self.view2.snp.makeConstraints { make in
            make.center.equalToSuperview()

            make.width.height.equalTo(150)
        }
        
        self.view5.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    lazy var view1: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.addCornerRadius(byRoundingCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 5)
        v.addBorder(color: .black, borderWidth: 1)
        return v
    }()
    
    lazy var view2: UIView = {
        let v = UIView()
        v.backgroundColor = .yellow.withAlphaComponent(0.5)
        return v
    }()
    
    lazy var view5: UIView = {
        let v = UIView()
//        v.backgroundColor = .green.withAlphaComponent(0.2)
        v.applyDropShadow(withOffset: CGSize.init(width: 0, height: -6), opacity: 1, radius: 5, color: UIColor.blue)
        return v
    }()
}
