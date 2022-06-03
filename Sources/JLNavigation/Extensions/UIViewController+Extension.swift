//
//  UIViewController+Extension.swift
//
//
//  Created by Luís Vieira on 04/04/2022.
//  Copyright © 2022 lsvra. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: Presentable
extension UIViewController: Presentable {

    public var presentable: UIViewController? { self }
}
#endif
