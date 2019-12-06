//
//  AppDelegate.swift
//  JoeWeather
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import RxSwift
import JoeWeatheriOS
import JoeWeatherUIKit
import JoeWeatherUIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var factory: MainFactory?
    var appCoordinator: AppCoordinator?
    var disposeBag = DisposeBag()
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        Theme.apply(to: window!)
        
        factory = MainFactory()
        appCoordinator = factory!.makeAppCoordinator(with: window!)
        appCoordinator?.start()
            .subscribe()
            .disposed(by: disposeBag)
    }
}

