//
//  XPDatePickView.swift
//  XPUIKit
//
//  Created by jamalping on 2024/3/9.
//

import Foundation
import UIKit
import SnapKit

struct XPDatePickData {
    var component: Int
    var dataSource: [Date]?
}

open class XPDatePickView: UIView {
    
    public let calendar = Calendar.current
    
    public let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MM月dd日"
        return formatter
    }()
    
    public var currentDate: Date = Date() {
        didSet {
            self.dataSource = self.generateDateSource(date: currentDate)
            self.pickView.selectRow(0, inComponent: 0, animated: false)
            
            self.dataSource[1].dataSource?.enumerated().forEach({ index, date in
                if calendar.isDate(self.currentDate, equalTo: date, toGranularity: .hour) {
                    self.pickView.selectRow(index, inComponent: 1, animated: false)
                }
            })
            
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: currentDate)
            components.minute! += 1
            guard let vDate = calendar.date(from: components) else { return }

            self.dataSource[2].dataSource?.enumerated().forEach({ index, date in
                if calendar.isDate(vDate, equalTo: date, toGranularity: .minute) {
                    self.pickView.selectRow(index, inComponent: 2, animated: false)
                }
            })
            
        }
    }
    
    var dataSource: [XPDatePickData] = [XPDatePickData]() {
        didSet {
            self.pickView.reloadAllComponents()
        }
    }
    var rowHeight: CGFloat = 50
    
    lazy var pickView: UIPickerView = {
        let pick = UIPickerView.init()
        pick.delegate = self
        pick.dataSource = self
        pick.backgroundColor = .red.withAlphaComponent(0.5)
        return pick
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.pickView)
        self.pickView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setDefaultDataSource()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XPDatePickView: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        self.dataSource.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataSource[component].dataSource?.count ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let rowDate = self.dataSource[component].dataSource?[row] else { return nil }
        if self.dataSource[component].component == 1 {
            if calendar.isDate(rowDate, inSameDayAs: Date()) {
                return "今天"
            }
            var weekString = ""
            let dateComponents = calendar.dateComponents([.weekday], from: rowDate)
            if let weekday = dateComponents.weekday {
                self.dateFormatter.locale = Locale(identifier: "zh_CN")
                weekString = self.dateFormatter.weekdaySymbols[weekday - 1]
            }
            self.dateFormatter.dateFormat = "MM月dd日"
            return "\(self.dateFormatter.string(from: rowDate)) \(weekString)"
        }
        
        if self.dataSource[component].component == 2 {
            self.dateFormatter.dateFormat = "HH"
            return "\(self.dateFormatter.string(from: rowDate))"
        }
        if self.dataSource[component].component == 3 {
            self.dateFormatter.dateFormat = "mm"
            return "\(self.dateFormatter.string(from: rowDate))"
        }
        return nil
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let rowDate = self.dataSource[component].dataSource?[row] else { return }
        print("选中了\(self.dateFormatter.string(from: rowDate))")
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return self.rowHeight
    }
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return UIScreen.main.bounds.width/2.0
        }
        return 50
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel.init()
        if component == 0 {
            label.textAlignment = .right
        }else {
            label.textAlignment = .left
        }
        
        label.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        return label
    }
}

extension XPDatePickView {
    
    func setDefaultDataSource() {
        
        self.dataSource = self.generateDateSource(date: Date())
        self.pickView.reloadAllComponents()
    }
    
    func generateDateSource(date: Date, count: Int = 31) -> [XPDatePickData] {
        var xpDatePickDatas = [XPDatePickData]()
        
        xpDatePickDatas.append(self.generateDate(date: date))
        if let hourDatePickData = self.generateHour(date: date) {
            xpDatePickDatas.append(hourDatePickData)
        }
        if let minuteDatePickData = self.generateMinute(date: date) {
            xpDatePickDatas.append(minuteDatePickData)
        }
        
        return xpDatePickDatas
    }
    
    /// 组装date
    func generateDate(date: Date, count: Int = 31) -> XPDatePickData {
        var dates = [Date]()
        for i in 0 ... count {
            if let rDate = calendar.date(byAdding: .day, value: i, to: date) {
                dates.append(rDate)
            }
        }
        return XPDatePickData.init(component: 1, dataSource: dates)
    }
    /// hour
    func generateHour(date: Date, count: Int = 24) -> XPDatePickData? {
        var dates = [Date]()
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.hour = 0
        components.minute = 0
        components.second = 0
        guard let vDate = calendar.date(from: components) else { return nil }
        for i in 0 ..< count {
            if let rDate = calendar.date(byAdding: .hour, value: i, to: vDate) {
                dates.append(rDate)
            }
        }
        
        return XPDatePickData.init(component: 2, dataSource: dates.sorted())
    }
    /// minute
    func generateMinute(date: Date, count: Int = 60) -> XPDatePickData? {
        var dates = [Date]()
        var components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        components.minute = 0
        components.second = 0
        guard let vDate = calendar.date(from: components) else { return nil }
        for i in 0 ..< count {
            if let rDate = calendar.date(byAdding: .minute, value: i, to: vDate) {
                dates.append(rDate)
            }
        }
        return XPDatePickData.init(component: 3, dataSource: dates)
    }
}
