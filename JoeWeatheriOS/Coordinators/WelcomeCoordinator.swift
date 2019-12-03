//
//  WelcomeCoordinator.swift
//  JoeWeatheriOS
//
//  Created by Joe on 11/29/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import RxSwift
import JoeWeatherKit
import JoeWeatherUIKit

public final class WelcomeCoordinator: BaseCoordinator {
    
    private let weatherViewController: WeatherViewController
    private let mainFactory: MainFactory
    private let locationRepository: LocationRepository
    private let disposeBag = DisposeBag()
    
    public init(with weatherViewController: WeatherViewController,
                        locationRepository: LocationRepository,
                               mainFactory: MainFactory) {
        self.weatherViewController = weatherViewController
        self.mainFactory = mainFactory
        self.locationRepository = locationRepository
    }
    
    public override func start() {
        let welcomeViewModel = mainFactory.makeWelcomeViewModel()
        let welcomeViewController = mainFactory.makeWelcomeViewController(with: welcomeViewModel)
        weatherViewController.render(contentVC: welcomeViewController)
        weatherViewController.tabBarController?.tabBar.isHidden = true
        
        welcomeViewModel.addLocationTapped
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let addLocationCoordinator = self.mainFactory.makeAddLocationCoordinator(with: welcomeViewController)
                self.coordinate(to: addLocationCoordinator)
            })
            .disposed(by: disposeBag)
    }

}

extension WelcomeCoordinator: AddLocationViewDelegate {

    public func updated(locations: [Location]) {
//        show(locations: locations)
     //   navigationController.dismiss(animated: true, completion: nil)
    }
    
    public func canceled() {
//        navigationController.dismiss(animated: true, completion: nil)
    }
}
