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

public final class WeatherCoordinator: BaseCoordinator<Void> {
    
    private let tabBarController: NiblessTabBarController
    private let locationRepository: LocationRepository
    private let disposeBag = DisposeBag()
    private let startWelcomeFlow = PublishSubject<Void>()
    private let startLocationsFlow = PublishSubject<[Location]>()
    
    public init(tabBarController: NiblessTabBarController,
              locationRepository: LocationRepository) {
        self.tabBarController = tabBarController
        self.locationRepository = locationRepository
    }
    
    public override func start() -> Observable<Void> {
        let weatherViewController = WeatherViewController()
        tabBarController.setViewControllers([weatherViewController], animated: true)
        let locationsImage = UIImage(systemName: "umbrella")
        weatherViewController.tabBarItem = UITabBarItem(title: "Weather", image: locationsImage, tag: 0)
        let loadingViewController = LoadingViewController()
        weatherViewController.render(contentVC: loadingViewController)
        weatherViewController.tabBarController?.tabBar.isHidden = true
        
        startWelcomeFlow
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let welcomeCoordinator = WelcomeCoordinator(with: weatherViewController,
                                              locationRepository: self.locationRepository)
                self.coordinate(to: welcomeCoordinator)
                    .subscribe(onNext: { [weak self] result in
                        switch result {
                        case .success(let locations):
                            self?.startLocationsFlow.onNext(locations)
                        case .failure(_):
                            break
                        }
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        startLocationsFlow
            .asObservable()
            .subscribe(onNext: { [weak self] locations in
                guard let self = self else { return }
                let locationsCoordinator = LocationsCoordinator(with: locations,
                                               weatherViewController: weatherViewController,
                                                  locationRepository: self.locationRepository)
                self.coordinate(to: locationsCoordinator)
                    .subscribe(onNext: { [weak self] locations in
                        if locations.isEmpty {
                            self?.startWelcomeFlow.onNext(())
                        }
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        locationRepository.readLocations().done { [weak self] locations in
            if locations.isEmpty {
                self?.startWelcomeFlow.onNext(())
            } else {
                self?.startLocationsFlow.onNext(locations)
            }
        }.cauterize()

        return Observable.never()
    }
}

extension WeatherCoordinator: UISplitViewControllerDelegate {
    public func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
