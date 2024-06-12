//
//  XPStackViewDemo.swift
//  XPUIKit_Example
//
//  Created by jamalping on 2024/6/12.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import XPUIKit
import SnapKit
import UIKit

class XPStackViewDemoVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.view.addSubview(self.vStackView)
        self.vStackView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(100)
        }
        
        self.contentView.addSubview(self.vStackView1)
        vStackView1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        self.vStackView.addArrangedSubview(self.label1)
//        self.vStackView.addArrangedSubview(self.hStackView)
        self.hStackView.addArrangedSubview(self.label2)
        self.hStackView.addArrangedSubview(self.label5)
        self.hStackView.addArrangedSubview(self.label3)
        
        self.label1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
        }
        self.label2.snp.makeConstraints { make in
            make.left.equalTo(self.label1)
        }
//        self.label4.snp.makeConstraints { make in
//            make.left.equalTo(self.label2)
//        }
//        self.label3.snp.makeConstraints { make in
//            make.right.equalToSuperview().offset(-8)
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.label1.text = "self.label1"
        self.label2.text = "self.label2"
        self.label3.text = "self.label3"
        self.label4.text = "self.label4"
    }
    
    lazy var vStackView: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [label1, contentView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 1
        stackView.backgroundColor = .red
        return stackView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var hStackView: UIStackView = {
        let stackView = UIStackView.init()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .top
        stackView.spacing = 10
        stackView.backgroundColor = .green
        return stackView
    }()
    
    lazy var label1: UILabel = {
        let label = UILabel()
        label.text = "label1"
        label.backgroundColor = UIColor.randamColor()
        return label
    }()
    
    lazy var label2: UILabel = {
        let label = UILabel()
        label.text = "label2"
        label.backgroundColor = UIColor.randamColor()
        return label
    }()
    
    lazy var label3: UILabel = {
        let label = UILabel()
        label.text = "label3"
        label.backgroundColor = UIColor.randamColor()
        return label
    }()
    
    lazy var label5: UILabel = {
        let label = UILabel()
        label.text = "label5"
        label.backgroundColor = UIColor.randamColor()
        return label
    }()
    
    lazy var vStackView1: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [hStackView, label4])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.backgroundColor = .red
        return stackView
    }()
    
    lazy var label4: UILabel = {
        let label = UILabel()
        label.text = "label4"
        label.backgroundColor = UIColor.randamColor()
        return label
    }()
}
