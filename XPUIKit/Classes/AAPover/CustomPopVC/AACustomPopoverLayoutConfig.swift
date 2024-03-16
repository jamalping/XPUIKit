//
//  AACustomPopoverLayoutConfig.swift
//  Pods
//
//  Created by jamalping on 2024/3/16.
//

import UIKit

public protocol AACustomPopoverLayoutConfigProtocol {
    var contentViewInsets: UIEdgeInsets { get set }
    
    var normalItemGap: CGFloat { get set }
        
    var cautionItemGap: CGFloat { get set }
    
    var differentTypesGap: CGFloat { get set }
    
    var dataSource: [PopVerData] { get set }
    
    var vWidth: CGFloat { get }
    
    var vHeight: CGFloat { get }
}

public struct AACustomPopoverDefaultLayout: AACustomPopoverLayoutConfigProtocol {
    
    public var contentViewInsets: UIEdgeInsets = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
    
    public var normalItemGap: CGFloat = 24.0

    public var cautionItemGap: CGFloat = 24.0
    
    public var differentTypesGap: CGFloat = 40.0
    
    public var dataSource: [PopVerData]
    
    public var vWidth: CGFloat {
        let maxItemWidth = self.dataSource.reduce(0) { partialResult, popVerData in
            partialResult > popVerData.itemWidth ? partialResult : popVerData.itemWidth
        }
        return maxItemWidth + contentViewInsets.left + contentViewInsets.right
    }
    public var vHeight: CGFloat {
        if dataSource.isEmpty { return 0 }
        let iHeight = contentViewInsets.top + contentViewInsets.bottom
        var popVerDataType = dataSource.first?.type ?? .normal
        let vHeight = dataSource.enumerated().reduce(iHeight) { (partialResult, arg1) in
            var vResult = partialResult
            let (index, popVerData) = arg1
            if arg1.0 == 0 {
                vResult += arg1.1.itemHeight
            }else {
                if popVerData.type == popVerDataType {
                    vResult += self.cautionItemGap
                    vResult += arg1.1.itemHeight
                }else {
                    vResult += self.differentTypesGap
                    vResult += arg1.1.itemHeight
                    popVerDataType = arg1.1.type
                }
            }
            return vResult
        }
        return vHeight
    }
}

