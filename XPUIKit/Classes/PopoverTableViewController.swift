//
//  PopoverTableViewController.swift
//  XPUIKit
//
//  Created by jamalping on 2024/3/16.
//

import UIKit

public class PopoverContentViewController: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // 可以在这里自定义你的视图内容
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 20))
        label.text = "这是一个PopoverView"
        view.addSubview(label)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        preferredContentSize = CGSize(width: 250, height: 100) // 根据内容调整Popover大小
    }
}



public class CustomPresentationController: UIPresentationController {
    // 背景遮罩
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.alpha = 0.0
        return view
    }()

    public override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        guard let containerView = containerView else { return }
        containerView.addSubview(dimmingView)
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }

    public override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()

        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }

    public override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let containerBounds = containerView.bounds
        var presentedViewFrame = CGRect.zero
        presentedViewFrame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
        
        // 调整弹窗大小和位置
        presentedViewFrame.origin.x = 0
//        (containerBounds.size.width - presentedViewFrame.size.width) / 2
        presentedViewFrame.origin.y = (containerBounds.size.height - presentedViewFrame.size.height) / 2
        
        return presentedViewFrame
    }
    
    // 可以在这里根据内容调整大小
    public override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width * 0.8, height: parentSize.height * 0.4)
    }

    public override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    public override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
    }
}

