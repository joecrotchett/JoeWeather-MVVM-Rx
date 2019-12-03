//
//  LocationsCoordinator.swift
//  JoeWeatheriOS
//
//  Created by Joe on 11/30/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import RxSwift
import JoeWeatherKit
import JoeWeatherUIKit

public final class LocationsCoordinator: BaseCoordinator {
    
    private let locations: [Location]
    private let weatherViewController: WeatherViewController
    private let mainFactory: MainFactory
    private let locationRepository: LocationRepository
    private let disposeBag = DisposeBag()
    
    public init(with locations: [Location],
         weatherViewController: WeatherViewController,
            locationRepository: LocationRepository,
                   mainFactory: MainFactory) {
        self.locations = locations
        self.weatherViewController = weatherViewController
        self.mainFactory = mainFactory
        self.locationRepository = locationRepository
    }
    
    public override func start() {
        let splitViewController = NiblessSplitViewController()
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.preferredPrimaryColumnWidthFraction = 0.5
        splitViewController.maximumPrimaryColumnWidth = 300
        splitViewController.delegate = self
        let masterNav = NiblessNavigationController(rootViewController: self.mainFactory.makeLocationListViewController(locations: locations, delegate: self))
        let detailNav = NiblessNavigationController(rootViewController: self.mainFactory.makeForecastViewController(for: locations.first!))
        splitViewController.viewControllers = [masterNav, detailNav]
        weatherViewController.render(contentVC: splitViewController)
        weatherViewController.tabBarController?.tabBar.isHidden = false
    }

}

extension LocationsCoordinator: UISplitViewControllerDelegate {
    public func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

extension LocationsCoordinator: LocationListViewDelegate {
    public func addLocation() {
        
    }
    
    
    public func listIsEmpty() {
       
    }
    
    public func selected(location: Location) {
        
    }
}
