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
    
//    public func makeMainCoordinator(with tabBarController: NiblessTabBarController) -> MainCoordinator {
//        return MainCoordinator(tabBarController: tabBarController,
//                             locationRepository: sharedLocationRepository,
//                                    mainFactory: self)
//    }
    
    public func makeAppCoordinator(with window: UIWindow) -> AppCoordinator {
        return AppCoordinator(window: window,
                  locationRepository: sharedLocationRepository,
                         mainFactory: self)
    }
    
    //MARK: Weather Story
    
    public func makeWeatherCoordinator(with tabBarController: NiblessTabBarController) -> WeatherCoordinator {
        return WeatherCoordinator(tabBarController: tabBarController,
                                locationRepository: sharedLocationRepository,
                                       mainFactory: self)
    }
    
    public func makeWeatherViewController(with viewModel: WeatherViewModel) -> WeatherViewController {
//        let viewModel = WeatherViewModel(locationRepository: sharedLocationRepository)
//        let viewController = WeatherViewController(viewModel: viewModel, delegate: delegate)
//        return viewController
        return WeatherViewController(viewModel: viewModel)
    }
    
    public func makeWeatherViewModel() -> WeatherViewModel {
        return WeatherViewModel(locationRepository: sharedLocationRepository)
    }
    
    //MARK: Welcome Story
    
    public func makeWelcomeCoordinator(with weatherViewController: WeatherViewController) -> WelcomeCoordinator {
        return WelcomeCoordinator(with: weatherViewController,
                    locationRepository: sharedLocationRepository,
                           mainFactory: self)
    }
    
    public func makeWelcomeViewController(with viewModel: WelcomeViewModel) -> WelcomeViewController {
        return WelcomeViewController(viewModel: viewModel)
    }
    
    public func makeWelcomeViewModel() -> WelcomeViewModel {
        return WelcomeViewModel()
    }
    
    //MARK: Add Location Story
    
    public func makeAddLocationCoordinator(with presentingViewController: NiblessViewController) -> AddLocationCoordinator {
        return AddLocationCoordinator(with: presentingViewController,
                        locationRepository: sharedLocationRepository,
                               mainFactory: self)
    }
    
    public func makeAddLocationViewController(with viewModel: AddLocationViewModel) -> AddLocationViewController {
        return AddLocationViewController(viewModel: viewModel)
    }
    
    public func makeAddLocationViewModel(with delegate: AddLocationViewDelegate) -> AddLocationViewModel {
        return AddLocationViewModel(locationRepository: sharedLocationRepository, delegate: delegate)
    }
    
    //MARK: Location List Story
    
    public func makeLocationsCoordinator(with locations: [Location],
                                  weatherViewController: WeatherViewController) -> LocationsCoordinator {
        return LocationsCoordinator(with: locations,
                   weatherViewController: weatherViewController,
                      locationRepository: sharedLocationRepository,
                             mainFactory: self)
    }
    
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
