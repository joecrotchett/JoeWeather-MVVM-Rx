//
//  WeatherCoordinator.swift
//  JoeWeatheriOS
//
//  Created by Joe on 11/29/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import RxSwift
import JoeWeatherKit
import JoeWeatherUIKit

public final class WeatherCoordinator: BaseCoordinator {
    
    private let tabBarController: NiblessTabBarController
    private let mainFactory: MainFactory
    private let locationRepository: LocationRepository
    private let disposeBag = DisposeBag()
    
    public init(tabBarController: NiblessTabBarController,
              locationRepository: LocationRepository,
                     mainFactory: MainFactory) {
        self.tabBarController = tabBarController
        self.mainFactory = mainFactory
        self.locationRepository = locationRepository
    }
    
    public override func start() {
        let weatherViewModel = mainFactory.makeWeatherViewModel()
        let weatherViewController = mainFactory.makeWeatherViewController(with: weatherViewModel)
        let locationsImage = UIImage(systemName: "umbrella")
        weatherViewController.tabBarItem = UITabBarItem(title: "Weather", image: locationsImage, tag: 0)
        tabBarController.setViewControllers([weatherViewController], animated: true)
        
        weatherViewModel
            .locations
            .asDriver { _ in fatalError("Unexpected error from locations observable.") }
            .drive(onNext: { [weak self] locations in
                guard let self = self else { return }
                if locations.isEmpty {
                    let welcomeCoordinator = self.mainFactory.makeWelcomeCoordinator(with: weatherViewController)
                    self.coordinate(to: welcomeCoordinator)
                } else {
                    let locationsCoordinator = self.mainFactory.makeLocationsCoordinator(with: locations,
                                                                        weatherViewController: weatherViewController)
                    self.coordinate(to: locationsCoordinator)
                }
            })
            .disposed(by: disposeBag)
        
        // TODO: here you could check if user is signed in and show appropriate screen
//        let coordinator = SignInCoordinator()
//        coordinator.navigationController = self.navigationController
//        self.start(coordinator: coordinator)
    }
}

//MARK: Weather Story

//extension WeatherCoordinator: WeatherViewControllerDelegate {
//    public func weatherViewController(_ sender: WeatherViewController, didUpdate locations: [Location]) {
//        if locations.isEmpty {
//            let welcomeViewController = self.mainFactory.makeWelcomeViewController(delegate: self)
//            sender.render(contentVC: welcomeViewController)
//            tabBarController.tabBar.isHidden = true
//        } else {
//            let splitViewController = NiblessSplitViewController()
//            splitViewController.preferredDisplayMode = .allVisible
//            splitViewController.preferredPrimaryColumnWidthFraction = 0.5
//            splitViewController.maximumPrimaryColumnWidth = 300
//            splitViewController.delegate = self
//            let masterNav = NiblessNavigationController(rootViewController: mainFactory.makeLocationListViewController(locations: locations, delegate: self))
//            let detailNav = NiblessNavigationController(rootViewController: mainFactory.makeForecastViewController(for: locations.first!))
//            splitViewController.viewControllers = [masterNav, detailNav]
//            sender.render(contentVC: splitViewController)
//            tabBarController.tabBar.isHidden = false
//        }
//    }
//}

//extension WeatherCoordinator: WelcomeViewControllerDelegate {
//    
//    public func welcomeViewControllerDidTapAddLocation(_ sender: WelcomeViewController) {
//        let addLocationViewController = mainFactory.makeAddLocationViewController(delegate: self)
//        sender.present(addLocationViewController, animated: true, completion: nil)
//    }
//}

extension WeatherCoordinator: UISplitViewControllerDelegate {
    public func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

extension WeatherCoordinator: LocationListViewDelegate {
    public func addLocation() {
        
    }
    
    
    public func listIsEmpty() {
       
    }
    
    public func selected(location: Location) {
        
    }
}

extension WeatherCoordinator: AddLocationViewDelegate {

    public func updated(locations: [Location]) {
//        show(locations: locations)
     //   navigationController.dismiss(animated: true, completion: nil)
    }
    
    public func canceled() {
//        navigationController.dismiss(animated: true, completion: nil)
    }
}
