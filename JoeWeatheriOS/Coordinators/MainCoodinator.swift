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

public final class MainCoordinator: Coordinator {
    
    public var window: UIWindow
    private let mainFactory: MainFactory
    private let locationRepository: LocationRepository
    
    public init(window: UIWindow,
    locationRepository: LocationRepository,
           mainFactory: MainFactory) {
        self.window = window
        self.mainFactory = mainFactory
        self.locationRepository = locationRepository
    }
    
    public func start() {
        let tabBarController = NiblessTabBarController()
        let welcomeViewController = self.mainFactory.makeWelcomeViewController(delegate: self)
        let locationsImage = UIImage(systemName: "umbrella")
        welcomeViewController.tabBarItem = UITabBarItem(title: "Locations", image: locationsImage, tag: 0)
        tabBarController.viewControllers = [welcomeViewController]
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
//        locationRepository.readLocations().done { [weak self] locations in
//            guard let self = self else { return }
//            if locations.isEmpty {
//                self.showWelcome()
//            } else {
//                self.show(locations: locations)
//            }
//        }.cauterize()
    }
    
    private func showWelcome() {
        let welcomeViewController = self.mainFactory.makeWelcomeViewController(delegate: self)
        let navigationController = NiblessNavigationController()
        window.rootViewController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(welcomeViewController, animated: false)
    }
    
    private func show(locations: [Location]) {
        guard locations.isEmpty == false else { return }
        let splitViewController = NiblessSplitViewController()
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.preferredPrimaryColumnWidthFraction = 0.5
        splitViewController.maximumPrimaryColumnWidth = 300
        splitViewController.delegate = self
        let masterNav = NiblessNavigationController(rootViewController: mainFactory.makeLocationListViewController(locations: locations, delegate: self))
        let detailNav = NiblessNavigationController(rootViewController: mainFactory.makeForecastViewController(for: locations.first!))
        splitViewController.viewControllers = [masterNav, detailNav]
        window.rootViewController = splitViewController
    }
    
    private func showForecast(for location: Location) {
        guard let splitViewController = window.rootViewController as? NiblessSplitViewController else { return }
        let forecastViewController = mainFactory.makeForecastViewController(for: location)
        splitViewController.showDetailViewController(forecastViewController, sender: nil)
    }
    
    private func showAddLocation() {
        let addLocationViewController = mainFactory.makeAddLocationViewController(delegate: self)
        guard let presenter = window.rootViewController else { return }
        presenter.present(addLocationViewController, animated: true, completion: nil)
    }
}

extension MainCoordinator: UISplitViewControllerDelegate {
    public func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
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
     //   navigationController.dismiss(animated: true, completion: nil)
    }
    
    public func canceled() {
//        navigationController.dismiss(animated: true, completion: nil)
    }
}
