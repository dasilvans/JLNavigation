//
//  JLCoordinator.swift
//  
//
//  Created by JDaSilva on 03/06/2022.
//  Copyright © 2022 JDaSilva. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public protocol JLCoordinator: AnyObject {

    var childCoordinators: [Coordinator] { get set }

    func start()
    func addChild(_ coordinator: Coordinator)
    func removeChild(_ coordinator: Coordinator)
}

extension JLCoordinator {

    public func addChild(_ coordinator: Coordinator) {

        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }

        childCoordinators.append(coordinator)
    }

    public func removeChild(_ coordinator: Coordinator) {

        guard !childCoordinators.isEmpty else { return }

        for (index, element) in childCoordinators.enumerated() where coordinator === element {

            childCoordinators.remove(at: index)
            break
        }
    }
}
#endif
