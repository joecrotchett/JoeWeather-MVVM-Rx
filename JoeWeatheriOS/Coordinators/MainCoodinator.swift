//
//  AppCoodinator.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherKit
import JoeWeatherUIKit
import OpenWeatherKit

public final class MainCoordinator: Coodinator {
    
    public var navigationController: UINavigationController
    private let mainFactory: MainFactory
    private let locationRepository: LocationRepository
    
    public init(navigationController: UINavigationController,
                  locationRepository: LocationRepository,
                         mainFactory: MainFactory) {
        self.navigationController = navigationController
        self.mainFactory = mainFactory
        self.locationRepository = locationRepository
    }
    
    public func start() {
        locationRepository.readLocations().done { [weak self] locations in
            guard let self = self else { return }
            if locations.isEmpty {
                self.showWelcome()
            } else {
                self.show(locations: locations)
            }
        }.cauterize()
    }
    
    private func showWelcome() {
        let welcomeViewController = self.mainFactory.makeWelcomeViewController(delegate: self)
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(welcomeViewController, animated: false)
    }
    
    private func show(locations: [Location]) {
        let locationListViewController = mainFactory.makeLocationListViewController(locations: locations, delegate: self)
        navigationController.viewControllers = [locationListViewController]
        navigationController.setNavigationBarHidden(false, animated: false)
    }
    
    private func showForecast(for location: Location) {
        let forecastViewController = mainFactory.makeForecastViewController(for: location)
        navigationController.pushViewController(forecastViewController, animated: true)
    }
    
    private func showAddLocation() {
        let addLocationViewController = mainFactory.makeAddLocationViewController(delegate: self)
        navigationController.present(addLocationViewController, animated: true, completion: nil)
    }
}

//MARK: Welcome Story

extension MainCoordinator: WelcomeViewDelegate {
    
    public func addLocation() {
        showAddLocation()
    }
}

//MARK: Location Story

extension MainCoordinator: LocationListViewDelegate {

    public func listIsEmpty() {
        showWelcome()
    }
    
    public func selected(location: Location) {
        showForecast(for: location)
    }
}

extension MainCoordinator: AddLocationViewDelegate {

    public func updated(locations: [Location]) {
        show(locations: locations)
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    public func canceled() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
