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
    
    private let mainFactory: MainFactory
    private let locationRepository: LocationRepository
    private let tabBarController: NiblessTabBarController
    
    public init(tabBarController: NiblessTabBarController,
              locationRepository: LocationRepository,
                     mainFactory: MainFactory) {
        self.tabBarController = tabBarController
        self.mainFactory = mainFactory
        self.locationRepository = locationRepository
    }
    
    public func start() {
        let weatherViewController = self.mainFactory.makeWeatherViewController(delegate: self)
        let locationsImage = UIImage(systemName: "umbrella")
        weatherViewController.tabBarItem = UITabBarItem(title: "Weather", image: locationsImage, tag: 0)
        tabBarController.viewControllers = [weatherViewController]
    }
    
    private func show(locations: [Location]) {
//        guard locations.isEmpty == false else { return }
//        let splitViewController = NiblessSplitViewController()
//        splitViewController.preferredDisplayMode = .allVisible
//        splitViewController.preferredPrimaryColumnWidthFraction = 0.5
//        splitViewController.maximumPrimaryColumnWidth = 300
//        splitViewController.delegate = self
//        let masterNav = NiblessNavigationController(rootViewController: mainFactory.makeLocationListViewController(locations: locations, delegate: self))
//        let detailNav = NiblessNavigationController(rootViewController: mainFactory.makeForecastViewController(for: locations.first!))
//        splitViewController.viewControllers = [masterNav, detailNav]
     
    }
    
    private func showForecast(for location: Location) {
//        guard let splitViewController = window.rootViewController as? NiblessSplitViewController else { return }
//        let forecastViewController = mainFactory.makeForecastViewController(for: location)
//        splitViewController.showDetailViewController(forecastViewController, sender: nil)
    }
}

extension MainCoordinator: UISplitViewControllerDelegate {
    public func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

//MARK: Weather Story

extension MainCoordinator: WeatherViewControllerDelegate {
    public func weatherViewController(_ sender: WeatherViewController, didUpdate locations: [Location]) {
        if locations.isEmpty {
            let welcomeViewController = self.mainFactory.makeWelcomeViewController(delegate: self)
            sender.render(contentVC: welcomeViewController)
            tabBarController.tabBar.isHidden = true
        } else {
            let splitViewController = NiblessSplitViewController()
            splitViewController.preferredDisplayMode = .allVisible
            splitViewController.preferredPrimaryColumnWidthFraction = 0.5
            splitViewController.maximumPrimaryColumnWidth = 300
            splitViewController.delegate = self
            let masterNav = NiblessNavigationController(rootViewController: mainFactory.makeLocationListViewController(locations: locations, delegate: self))
            let detailNav = NiblessNavigationController(rootViewController: mainFactory.makeForecastViewController(for: locations.first!))
            splitViewController.viewControllers = [masterNav, detailNav]
            sender.render(contentVC: splitViewController)
            tabBarController.tabBar.isHidden = false
        }
    }
}

//MARK: Welcome Story

extension MainCoordinator: WelcomeViewControllerDelegate {
    
    public func welcomeViewControllerDidTapAddLocation(_ sender: WelcomeViewController) {
        let addLocationViewController = mainFactory.makeAddLocationViewController(delegate: self)
        sender.present(addLocationViewController, animated: true, completion: nil)
    }
}

//MARK: Location Story

extension MainCoordinator: LocationListViewDelegate {
    public func addLocation() {
        
    }
    
    
    public func listIsEmpty() {
       
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
