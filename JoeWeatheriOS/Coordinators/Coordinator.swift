//
//  Coordinator.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherUIKit

public protocol Coordinator: class {
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func coordinate(to coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
}
 
open class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    public var parentCoordinator: Coordinator?
    
    public func start() {
        fatalError("Start method must be implemented")
    }
    
    public func coordinate(to coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    public func didFinish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
}
