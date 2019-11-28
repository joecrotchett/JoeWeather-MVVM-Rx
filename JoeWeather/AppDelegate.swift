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
        window = UIWindow(frame: UIScreen.main.bounds)
        Theme.apply(to: window!)
        
        factory = MainFactory()
        coordinator = factory?.makeMainCoordinator(with: window!)
        coordinator?.start()
    }
}

