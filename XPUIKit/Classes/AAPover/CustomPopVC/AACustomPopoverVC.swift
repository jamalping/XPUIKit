//
//  AACustomPopoverVC.swift
//  XPUIKit
//
//  Created by jamalping on 2024/3/16.
//

import Foundation
import UIKit
import SnapKit

enum PopVerDataType {
    case normal, caution
}

public enum PopVerData {
    case normal(Pdata)
    case caution(Pdata)
    
    public struct Pdata {
        var image: String = "popover_arrow_icon"
        var title: String = "title"
    }
    
    var gap: CGFloat {
        return 8
    }

    var fontSize: CGFloat {
        return 15
    }
    
    var iconSize: CGSize {
        return CGSize.init(width: 22, height: 22)
    }
    var textColor: UIColor {
        return UIColor.gray
    }
    
    var textWidth: CGFloat {
        switch self {
        case .normal(let pdata):
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: self.fontSize)]
            return pdata.title.boundingRect(with: CGSize.init(width: CGFloat.infinity, height: self.itemHeight), options: [], attributes: attributes, context: nil).size.width
        case .caution(let pdata):
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: self.fontSize)]
            return pdata.title.boundingRect(with: CGSize.init(width: CGFloat.infinity, height: self.itemHeight), options: [], attributes: attributes, context: nil).size.width
        }
    }
    
    var itemWidth: CGFloat {
        return self.iconSize.width+gap+textWidth
    }
    
    var itemHeight: CGFloat {
        return 20.0
    }
    
    var type: PopVerDataType {
        switch self {
        case .normal(_):
            return .normal
        case .caution(_):
            return .caution
        }
    }
    func isSameType(popVerData: PopVerData) -> Bool {
        switch self {
        case .normal(_):
            if case .normal(_) = popVerData {
                return true
            }
        case .caution(_):
            if case .caution(_) = popVerData {
                return true
            }
        }
        return false
    }
}

public class AACustomPopoverVC: AABasePopoverVC<CustomBgView> {
    
    public var popoverLayout: AACustomPopoverLayoutConfigProtocol!
    
    private var _size: CGSize = CGSize.init(width: 200, height: 150)
    public override var size: CGSize {
        get {
            return _size
        }
        set {
            _size = newValue
        }
    }
    
    private var _sourceRect: CGRect = .zero
    public override var sourceRect: CGRect{
        get {
            return _sourceRect
        }
        set {
            _sourceRect = newValue
        }
    }
    
    public var dataSource: [PopVerData] = [.normal(PopVerData.Pdata()),.normal(PopVerData.Pdata()),.normal(PopVerData.Pdata()),.caution(PopVerData.Pdata.init(image: "", title: "asdghjkdfsdfghgdsfghsdsdffghhlgsdfkh"))] {
        didSet {
            self.popoverLayout = AACustomPopoverDefaultLayout.init(dataSource: self.dataSource)
        }
    }
    
    public init(sourceView: UIView) {
        popoverLayout = AACustomPopoverDefaultLayout.init(dataSource: self.dataSource)
        _size = CGSize.init(width: popoverLayout!.vWidth, height: popoverLayout!.vHeight)
        super.init(size: _size)
        
        self.sourceView = sourceView
        
//        self.dataSource.compactMap { popVerData in
//            if case .normal(pData) = popVerData {
//                return ItemView.init()
//            }
//            return nil
//        }
        
        self.sourceRect = CGRect.init(x: sourceView.bounds.maxX, y: sourceView.bounds.maxY, width: 0, height: 0)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
//        self.dataSource
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        
//        UIStackView
        
        self.view.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { make in
            make.edges.equalTo(self.popoverLayout.contentViewInsets)
        }
        var lastView: ItemView? = nil
        self.dataSource.compactMap { popVerData in
            let item = ItemView()
            item.popVerData = popVerData
            
            /// add lineView
            if let lastView = lastView, let lastPopverDataType = lastView.popVerData?.type, lastPopverDataType != popVerData.type {
                self.containerView.addSubview(self.lineView)
                self.lineView.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(1)
                    make.top.equalTo(lastView.snp.bottom).offset(popoverLayout.differentTypesGap/2.0)
                }
            }
            /// add item
            self.containerView.addSubview(item)
            item.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(popVerData.itemHeight)
                if let lastView = lastView {
                    if let lastPopverDataType = lastView.popVerData?.type, lastPopverDataType == popVerData.type {
                        make.top.equalTo(lastView.snp.bottom).offset(self.popoverLayout.cautionItemGap)
                    }else {
                        make.top.equalTo(lastView.snp.bottom).offset(self.popoverLayout.differentTypesGap)
                    }
                }else {
                    make.top.equalToSuperview()
                }
            }
            lastView = item
        }
    }
    

    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.separator
        return view
    }()
}

public class ItemView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configPage()
    }
    
    var popVerData: PopVerData? {
        didSet {
            guard let popVerData = popVerData else { return }
            switch popVerData {
            case .normal(let pdata):
                self.setData(pdata)
            case .caution(let pdata):
                self.setData(pdata)
            }
        }
    }
    
    func setData(_ pData: PopVerData.Pdata) {
        self.titleLabel.text = pData.title
        self.iconView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configPage() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.iconView)
        
        layout()
    }
    
    func layout() {
        self.iconView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
            
        }
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.iconView.snp.right).offset(8)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.text = "已成交"
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.gray
//        titleLabel.fontSize = MixFont(normal: popConfig.normalTextFont, other: popConfig.largeTextFont)
//        titleLabel.aaTextColor = themeColor{ ColorManager.font2_sub }
//        titleLabel.aaBackgroundColor = themeColor{ ColorManager.bg_3a }
        return titleLabel
    }()
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
//        if let image = UIImage(nameInBundle: "iconImPrompt") {
//            imageView.aaImageColor = themeImageColor{
//                return (normalImage: image, normalColors: [ColorManager.primary_colour1,ColorManager.primary_colour2], selectImage: nil, selectColors: nil, direction: .bottom)
//            }
//        }
        return imageView
    }()
    
}


