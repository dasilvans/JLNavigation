//
//  JLRouter.swift
//  
//
//  Created by JDaSilva on 03/06/2022.
//  Copyright © 2022 JDaSilva. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public protocol JLRouter: AnyObject, Presentable {

    func setRootModule(_ module: Presentable, animated: Bool)

    func present(_ module: Presentable, animated: Bool)
    func dismissModule(animated: Bool, completion: (() -> Void)?)
}
#endif
