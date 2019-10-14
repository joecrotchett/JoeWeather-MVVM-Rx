//
//  WeatherAppFactory.swift
//  WeatheriOS
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherKit
import JoeWeatherUIKit
import OpenWeatherKit

public class MainFactory {
    
    private let sharedLocationRepository: LocationRepository
    
    public init() {
        
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
        
        self.sharedLocationRepository = makeLocationRepository()
    }
    
    public func makeMainCoordinator(with navigationController: UINavigationController) -> MainCoordinator {
        return MainCoordinator(navigationController: navigationController,
                                 locationRepository: sharedLocationRepository,
                                        mainFactory: self)
    }
    
    //MARK: Welcome Story
    
    public func makeWelcomeViewController(delegate: WelcomeViewDelegate) -> WelcomeViewController {
        let viewModel = WelcomeViewModel(locationRepository: sharedLocationRepository, delegate: delegate)
        let viewController = WelcomeViewController(viewModel: viewModel)
        return viewController
    }
    
    public func makeAddLocationViewController(delegate: AddLocationViewDelegate) -> AddLocationViewController {
        let viewModel = AddLocationViewModel(locationRepository: sharedLocationRepository, delegate: delegate)
        let viewController = AddLocationViewController(viewModel: viewModel)
        return viewController
    }
    
    //MARK: Location List Story
    
    public func makeLocationListViewController(locations: [Location], delegate: LocationListViewDelegate) -> LocationListViewController {
        let viewModel = LocationListViewModel(locations: locations, locationRepository: sharedLocationRepository, delegate: delegate)
        let viewController = LocationListViewController(viewModel: viewModel)
        return viewController
    }
    
    public func makeForecastViewController(for location: Location) -> ForecastViewController {
        let viewModel = ForecastViewModel(location: location)
        let viewController = ForecastViewController(viewModel: viewModel)
        return viewController
    }
}
