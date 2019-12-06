//
//  Coordinator.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import RxSwift
import JoeWeatherUIKit

public protocol Coordinator: class {
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func coordinate(to coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
}
 
//open class BaseCoordinator<Result>: Coordinator {
open class BaseCoordinator<Result> {
    
    private var childCoordinators = [UUID: Any]()
    public var parentCoordinator: Coordinator?
    private let identifier = UUID()
    
    func start() -> Observable<Result> {
        fatalError("Start method should be implemented.")
    }
    
    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in
                self?.free(coordinator: coordinator)
            })
    }
    
//    public func coordinate(to coordinator: Coordinator) {
//        self.childCoordinators.append(coordinator)
//        coordinator.parentCoordinator = self
//        coordinator.start()
//    }
    
//    public func didFinish(coordinator: Coordinator) {
//        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
//            self.childCoordinators.remove(at: index)
//        }
//    }
    
    //MARK: Private
    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
}

