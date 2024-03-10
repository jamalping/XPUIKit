//
//  ViewController.swift
//  XPUIKit
//
//  Created by jamalping on 03/09/2024.
//  Copyright (c) 2024 jamalping. All rights reserved.
//

import UIKit
import SnapKit
import XPUIKit

class ViewController: UIViewController {

    enum TestType: String {
        case UIViewStyle = "UIViewStyle"
        case DatePickView = "datapick"
    }

    let datasource: [TestType] = [.UIViewStyle, .DatePickView]
    lazy var tableView: UITableView = {
        let tableView = UITableView.init()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIKit"
        
        tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell!.textLabel?.text = self.datasource[indexPath.row].rawValue
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch self.datasource[indexPath.row] {
        case .UIViewStyle:
            self.navigationController?.pushViewController(UIViewStyleVC(), animated: true)
        case .DatePickView:
            self.navigationController?.pushViewController(XPDatePickVC(), animated: true)
            
        default: break
            
        }
    }
}




