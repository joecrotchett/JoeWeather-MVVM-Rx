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

public final class WelcomeCoordinator: BaseCoordinator<Result<[Location], Error>> {
    
    private let weatherViewController: WeatherViewController
    private let locationRepository: LocationRepository
    private let disposeBag = DisposeBag()
    
    public init(with weatherViewController: WeatherViewController,
                        locationRepository: LocationRepository) {
        self.weatherViewController = weatherViewController
        self.locationRepository = locationRepository
    }
    
    public override func start() -> Observable<Result<[Location], Error>>{
        let welcomeViewModel = WelcomeViewModel()
        let welcomeViewController = WelcomeViewController(viewModel: welcomeViewModel)
        weatherViewController.render(contentVC: welcomeViewController)
        weatherViewController.tabBarController?.tabBar.isHidden = true
        
        let locationAdded = PublishSubject<Result<[Location], Error>>()
        
        welcomeViewModel.addLocationTapped
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let addLocationCoordinator = AddLocationCoordinator(with: welcomeViewController,
                                                      locationRepository: self.locationRepository)
                self.coordinate(to: addLocationCoordinator)
                    .subscribe(onNext: { result in
                        switch result {
                        case .success(let locations):
                            if let locations = locations {
                                locationAdded.onNext(Result<[Location], Error>.success(locations))
                            }
                        case .failure(_):
                            break
                        }
                        }).disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        return locationAdded.asObservable()
    }
}
