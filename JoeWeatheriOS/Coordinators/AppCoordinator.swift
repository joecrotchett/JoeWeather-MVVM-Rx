//
//  AppCoordinator.swift
//  JoeWeatheriOS
//
//  Created by Joe on 11/29/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import RxSwift
import JoeWeatherKit
import JoeWeatherUIKit

public final class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    private let locationRepository: LocationRepository
    
    public init(window: UIWindow,
    locationRepository: LocationRepository) {
        self.window = window
        self.locationRepository = locationRepository
    }
    
    public override func start() -> Observable<Void> {
        let tabBarController = NiblessTabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    
        let weatherCoordinator = WeatherCoordinator(tabBarController: tabBarController,
                                                  locationRepository: locationRepository)
        return coordinate(to: weatherCoordinator)
    }
}
