//
//  AppDelegate.swift
//  JoeWeather
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import RxSwift
import OpenWeatherKit
import JoeWeatheriOS
import JoeWeatherKit
import JoeWeatherUIKit
import JoeWeatherUIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var locationRepository: LocationRepository?

    var disposeBag = DisposeBag()
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        Theme.apply(to: window!)
     
        self.locationRepository = makeLocationRepository()
        appCoordinator = AppCoordinator(window: window!,
                            locationRepository: locationRepository!)

        appCoordinator?.start()
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func makeWeatherAPI() -> WeatherAPI {
        OpenWeatherMapKit.initialize(withAppId: "24e017c4af6df1a98c5ed63860f4847b")
        let openWeatherAPI = OpenWeatherMapKit.instance
        let weatherAPI = OpenWeatherAPI(openWeather: openWeatherAPI)
        return weatherAPI
    }
    
    func makeLocationDataStore() -> LocationDataStore {
        return FileDataStore()
    }
    
    func makeLocationRepository() -> LocationRepository {
        let weatherAPI = makeWeatherAPI()
        let dataStore = makeLocationDataStore()
        let locationRepository = LocationRepository(dataStore: dataStore,
                                                  weatherAPI: weatherAPI)
        return locationRepository
    }
}

