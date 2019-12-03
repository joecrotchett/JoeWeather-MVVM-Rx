//
//  AppCoordinator.swift
//  JoeWeatheriOS
//
//  Created by Joe on 11/29/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherKit
import JoeWeatherUIKit

public final class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private let mainFactory: MainFactory
    private let locationRepository: LocationRepository
    
    public init(window: UIWindow,
    locationRepository: LocationRepository,
           mainFactory: MainFactory) {
        self.window = window
        self.mainFactory = mainFactory
        self.locationRepository = locationRepository
    }
    
    public override func start() {
        let tabBarController = NiblessTabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    
        let weatherCoordinator = mainFactory.makeWeatherCoordinator(with: tabBarController)
        coordinate(to: weatherCoordinator)
    }
}
