//
//  JLNavigationRouter.swift
//  
//
//  Created by JDaSilva on 03/06/2022.
//  Copyright © 2022 JDaSilva. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public protocol JLNavigationRouter: JLRouter {

    var navigation: UINavigationController { get }
    var completions: [UIViewController : () -> Void] { get set }

    func push(_ module: Presentable, animated: Bool, completion: (() -> Void)?)
    func setRootModule(_ module: Presentable, hideBar: Bool)
    func popModule(animated: Bool)
    func popToRootModule(animated: Bool)
}

extension JLNavigationRouter {

    public func push(_ module: Presentable, animated: Bool = true, completion: (() -> Void)? = nil) {

        guard let controller = module.presentable else { return }

        // Avoid pushing UINavigationController onto stack
        guard !(controller is UINavigationController) else { return }

        if let completion = completion {
            completions[controller] = completion
        }

        navigation.pushViewController(controller, animated: animated)
    }

    public func add(child: Presentable, toParent parent: Presentable) {

        guard
            let childViewController = child.presentable,
            let parentViewController = parent.presentable
            else { return }

        parentViewController.addChild(childViewController)
        parentViewController.view.addSubview(childViewController.view)
        childViewController.didMove(toParent: parentViewController)
        childViewController.view.frame = parentViewController.view.frame
    }

    public func popModule(animated: Bool = true) {

        if let controller = navigation.popViewController(animated: animated) {
              runCompletion(for: controller)
        }
    }

    public func popToRootModule(animated: Bool) {

        if let controllers = navigation.popToRootViewController(animated: animated) {
             controllers.forEach { runCompletion(for: $0) }
        }
    }

    fileprivate func runCompletion(for controller: UIViewController) {

        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

// MARK: Router
extension NavigationRouter {

    public var presentable: UIViewController? { navigation }

    public func present(_ module: Presentable, animated: Bool = true) {

        guard let presentable = module.presentable else { return }
        navigation.present(presentable, animated: animated, completion: nil)
    }

    public func dismissModule(animated: Bool, completion: (() -> Void)?) {
        navigation.dismiss(animated: animated, completion: completion)
    }

    public func setRootModule(_ module: Presentable, hideBar: Bool) {

        navigation.isNavigationBarHidden = hideBar
        setRootModule(module)
    }

    public func setRootModule(_ module: Presentable, animated: Bool = false) {

        guard let presentable = module.presentable else { return }

        completions.forEach { $0.value() }
        navigation.setViewControllers([presentable], animated: animated)
    }
}

// MARK: UINavigationControllerDelegate
extension JLNavigationRouter where Self: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {

        guard
            let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(poppedViewController)
            else { return }

        runCompletion(for: poppedViewController)
    }
}
#endif
