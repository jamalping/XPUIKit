//
//  XPPopoverVC.swift
//  XPUIKit_Example
//
//  Created by jamalping on 2024/3/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import XPUIKit

class XPPopoverVC: UIViewController {
    
    let datasource: [Int] = [1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,4,7,5,4]
    
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

extension XPPopoverVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell!.textLabel?.text = "\(self.datasource[indexPath.row])"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.contentView.backgroundColor = .red
        
        let vc = XPCustomPopoverVC.init(sourceView: cell)
        present(vc, animated: true, completion: nil)

    }
    
    
        
        
}

