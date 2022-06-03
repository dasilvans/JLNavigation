//
//  JLPresentable.swift
//
//
//  Created by Luís Vieira on 04/06/2022.
//  Copyright © 2022 lsvra. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public protocol JLPresentable {

    var presentable: UIViewController? { get }
}
#endif
