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
    
    public override func start() -> Observable<[Location]> {
        let locationListViewModel = self.mainFactory.makeLocationListViewModel(with: self.locations)
        let locationListViewController = self.mainFactory.makeLocationListViewController(with: locationListViewModel, delegate: self)
        let splitViewController = NiblessSplitViewController()
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.preferredPrimaryColumnWidthFraction = 0.5
        splitViewController.maximumPrimaryColumnWidth = 300
        splitViewController.delegate = self
        let masterNav = NiblessNavigationController(rootViewController: locationListViewController)
        let detailNav = NiblessNavigationController(rootViewController: self.mainFactory.makeForecastViewController(for: locations.first!))
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
                let addLocationCoordinator = self.mainFactory.makeAddLocationCoordinator(with: locationListViewController)
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
            .subscribe(onNext: { [weak self] location in
                guard let self = self else { return }
                let forecastViewController = self.mainFactory.makeForecastViewController(for: location)
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

extension LocationsCoordinator: LocationListViewDelegate {
    public func addLocation() {
        
    }
    
    
    public func listIsEmpty() {
       
    }
    
    public func selected(location: Location) {
        
    }
}
