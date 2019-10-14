//
//  AppDelegate.swift
//  JoeWeather
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatheriOS
import JoeWeatherUIKit
import JoeWeatherUIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var factory: MainFactory?
    var coordinator: MainCoordinator?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        let navigationController = NiblessNavigationController()
        factory = MainFactory()
        coordinator = factory?.makeMainCoordinator(with: navigationController)
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        Theme.apply(to: window!)
    }
}

