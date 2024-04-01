//
//  XPDatePickVC.swift
//  XPUIKit_Example
//
//  Created by jamalping on 2024/3/10.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import XPUIKit
import SnapKit

class XPDatePickVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "DatePick"
        view.backgroundColor = .white
        
        self.view.addSubview(self.datePick)
        self.datePick.snp.makeConstraints { make in
            make.center.width.equalToSuperview()
            make.height.equalTo(150)
        }
        self.datePick.currentDate = Date()
    }
    
    lazy var datePick = XPDatePickView()
}
