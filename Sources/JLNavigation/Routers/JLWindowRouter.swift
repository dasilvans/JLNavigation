//
//  JLWindowRouter.swift
//  
//
//  Created by JDaSilva on 03/06/2022.
//  Copyright © 2022 JDaSilva. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public protocol JLWindowRouter: Router {

    var window: UIWindow { get set }
}

extension JLWindowRouter {

    public func present(_ module: Presentable, animated: Bool) {

        guard let presentable = module.presentable else { return }
        window.rootViewController?.present(presentable, animated: animated, completion: nil)
    }

    public func dismissModule(animated: Bool, completion: (() -> Void)?) {

        window.rootViewController?.dismiss(animated: animated, completion: completion)
    }
}

// MARK: Router
extension JLWindowRouter {

    private var animationDuration: TimeInterval { 0.3 }

    public var presentable: UIViewController? { window.rootViewController }

    public func setRootModule(_ module: Presentable, animated: Bool = true) {

        window.rootViewController = module.presentable
        window.makeKeyAndVisible()

        if animated {
            UIView.transition(with: window,
                              duration: animationDuration,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
}
#endif
