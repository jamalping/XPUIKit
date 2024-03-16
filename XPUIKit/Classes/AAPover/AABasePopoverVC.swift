//
//  AABasePopoverVC.swift
//  XPUIKit
//
//  Created by jamalping on 2024/3/16.
//

import UIKit

open class AABasePopoverVC<T:UIPopoverBackgroundView>: UIViewController,UIPopoverPresentationControllerDelegate {
    public var sourceView: UIView? = nil
    ///用于确定弹窗的位置
    public var sourceRect:CGRect = .zero
    ///弹窗的大小
    public var size:CGSize = .zero
    ///是否可以点击背景消失
    public var enableDismiss = true
    ///点击背景消失后的回调
    public var didDismiss:(() -> Void)? = nil
    public var bgView:UIView!
    ///弹窗边框宽度
    public var popBorderWidth: CGFloat{
        return view.superview?.layer.borderWidth ?? 0
    }
    
    ///弹窗边框颜色
    public var popBorderColor: CGColor?{
        return view.superview?.layer.borderColor
    }
    ///弹窗的圆角
    public var popCornerRadius: CGFloat{
        return view.superview?.layer.cornerRadius ?? 0
    }
    
    ///弹窗要设置圆角的角
    @available(iOS 11.0, *)
    public var popMaskedCorners: CACornerMask{
        return view.superview?.layer.maskedCorners ?? []
    }
    
    
    public init(size: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.size = size
        initPopVC()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initPopVC()
    }
    
    func initPopVC(){
        //必须在弹窗弹出前设置modalPresentationStyle
        modalPresentationStyle = .popover
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.delegate = self
        popoverPresentationController?.canOverlapSourceViewRect = true
        popoverPresentationController?.popoverBackgroundViewClass = T.self
        popoverPresentationController?.backgroundColor = .blue
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        //防止使用storyboard后没有设置contentSize
        //子类要再super.viewDidLoad()之前设置size
        if size.equalTo(.zero) {
            fatalError("must set vc's size")
        }

        preferredContentSize = size
//        self.sourceRect.origin.y = 0
        popoverPresentationController?.sourceRect = self.sourceRect
        //从A控制器通过present的方式跳转到了B控制器，那么 A.presentedViewController 就是B控制器；B.presentingViewController 就是A控制器
        //不能在init中，因为presentingViewController在init中为nil
        weak var presentingView = presentingViewController?.view
        popoverPresentationController?.sourceView = sourceView ?? presentingView
        bgView = UIView.init(frame: UIScreen.main.bounds)
        bgView.backgroundColor = UIColor.init(white: 0, alpha: 0.0)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentingViewController?.view.addSubview(bgView)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        bgView.removeFromSuperview()
    }
    
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.superview?.layer.borderWidth = popBorderWidth
        view.superview?.layer.borderColor = popBorderColor
        view.superview?.layer.cornerRadius = popCornerRadius
        if #available(iOS 11.0, *) {
            view.superview?.layer.maskedCorners = popMaskedCorners
        }
    }
    
    //MARK:UIPopoverPresentationControllerDelegate
    public func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return enableDismiss
    }
    
    @available(iOS 13.0, *)
    public func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return enableDismiss
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    public func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        didDismiss?()
        didDismiss = nil
    }
    
    @available(iOS 13.0, *)
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        didDismiss?()
        didDismiss = nil
    }
}


//移除了箭头的弹窗背景
open class BasePopoverBgView : UIPopoverBackgroundView {
    /// 控制箭头显示的属性
    public static var showArrow: Bool = false
    ///弹窗背景的阴影偏移
    public var popShadowOffset: CGSize{
        return layer.shadowOffset
    }
    ///弹窗背景的阴影圆角
    public var popShadowRadius: CGFloat{
        return layer.shadowRadius
    }
    ///弹窗背景的阴影不透明度
    public var popShadowOpacity: Float{
        return layer.shadowOpacity
    }
    ///弹窗背景的阴影颜色
    public var popShadowColor: CGColor?{
        return layer.shadowColor
    }
    
    public override static func contentViewInsets() -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public override static func arrowHeight() -> CGFloat {
        return showArrow ? 20 : 0
    }
    open override class func arrowBase() -> CGFloat {
        return showArrow ? 20 : 0
    }
   
    private var _arrowDirection: UIPopoverArrowDirection = .up
    open override var arrowDirection: UIPopoverArrowDirection {
        get { return _arrowDirection }
        set {
            _arrowDirection = newValue
            setNeedsLayout()
        }
    }
    
    private var _arrowOffset: CGFloat = 0
    open override var arrowOffset: CGFloat {
        get { return
            _arrowOffset
        }
        set {
            _arrowOffset = newValue
            setNeedsLayout()
        }
    }
    private var arrowImageView: UIImageView?
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .clear
            
        if BasePopoverBgView.showArrow {
            arrowImageView = UIImageView(image: UIImage(named: "popover_arrow_icon")) // 替换为您的箭头图像
            if let arrowImageView = arrowImageView {
                self.addSubview(arrowImageView)
            }
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowOffset = popShadowOffset
        self.layer.shadowRadius = popShadowRadius
        self.layer.shadowOpacity = popShadowOpacity
        self.layer.shadowColor = popShadowColor
        
        if let arrowImageView = arrowImageView, BasePopoverBgView.showArrow {
            // 根据箭头方向和偏移量调整箭头图像的位置
            arrowImageView.frame = CGRect(x: (self.bounds.width - BasePopoverBgView.arrowBase()) / 2 + arrowOffset, y: self.bounds.height, width: BasePopoverBgView.arrowBase(), height: BasePopoverBgView.arrowHeight())
        }
    }
}

