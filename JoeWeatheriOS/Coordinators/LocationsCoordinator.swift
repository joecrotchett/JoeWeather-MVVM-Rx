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

public final class LocationsCoordinator: BaseCoordinator<[Location]> {
    
    private let locations: [Location]
    private let weatherViewController: WeatherViewController
    private let locationRepository: LocationRepository
    private let disposeBag = DisposeBag()
    
    public init(with locations: [Location],
         weatherViewController: WeatherViewController,
            locationRepository: LocationRepository) {
        self.locations = locations
        self.weatherViewController = weatherViewController
        self.locationRepository = locationRepository
    }
    
    public override func start() -> Observable<[Location]> {
        let locationListViewModel = LocationListViewModel(locations: locations, locationRepository: locationRepository)
        let locationListViewController = LocationListViewController(viewModel: locationListViewModel)
        let forecastViewModel = ForecastViewModel(location: locations.first!)
        let forecastViewController = ForecastViewController(viewModel: forecastViewModel)
        let splitViewController = NiblessSplitViewController()
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.preferredPrimaryColumnWidthFraction = 0.5
        splitViewController.maximumPrimaryColumnWidth = 300
        splitViewController.delegate = self
        let masterNav = NiblessNavigationController(rootViewController: locationListViewController)
        let detailNav = NiblessNavigationController(rootViewController: forecastViewController)
        splitViewController.viewControllers = [masterNav, detailNav]
        weatherViewController.render(contentVC: splitViewController)
        weatherViewController.tabBarController?.tabBar.isHidden = false
        
        let locationsUpdated = PublishSubject<[Location]>()
        
        locationListViewModel.locations
            .subscribe(onNext: { locations in
                locationsUpdated.onNext(locations)
            })
            .disposed(by: disposeBag)
        
        locationListViewModel.didTapAddLocation
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let addLocationCoordinator = AddLocationCoordinator(with: locationListViewController,
                                                      locationRepository: self.locationRepository)
                self.coordinate(to: addLocationCoordinator)
                    .subscribe(onNext: { result in
                        switch result {
                        case .success(let locations):
                            if let locations = locations {
                                locationListViewModel.locations.onNext(locations)
                            }
                        case .failure(_):
                            break
                        }
                        }).disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        locationListViewModel.didSelectLocation
            .subscribe(onNext: { location in
                let forecastViewModel = ForecastViewModel(location: location)
                let forecastViewController = ForecastViewController(viewModel: forecastViewModel)
                splitViewController.showDetailViewController(forecastViewController, sender: nil)
            })
            .disposed(by: disposeBag)
        
        return locationsUpdated.asObservable()
    }

}

extension LocationsCoordinator: UISplitViewControllerDelegate {
    public func splitViewController(_ splitViewController: UISplitViewController,
                collapseSecondary secondaryViewController: UIViewController,
                               onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
