//
//  AddLocationCoordinator.swift
//  JoeWeatheriOS
//
//  Created by Joe on 11/30/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import RxSwift
import JoeWeatherKit
import JoeWeatherUIKit

public final class AddLocationCoordinator: BaseCoordinator {
    
    private let presentingViewController: NiblessViewController
    private let mainFactory: MainFactory
    private let locationRepository: LocationRepository
    private let disposeBag = DisposeBag()
    
    public init(with presentingViewController: NiblessViewController,
                           locationRepository: LocationRepository,
                                  mainFactory: MainFactory) {
        self.presentingViewController = presentingViewController
        self.mainFactory = mainFactory
        self.locationRepository = locationRepository
    }
    
    public override func start() {
        let addLocationViewModel = mainFactory.makeAddLocationViewModel(with: self)
        let addLocationViewController = mainFactory.makeAddLocationViewController(with: addLocationViewModel)
        self.presentingViewController.present(addLocationViewController, animated: true, completion: nil)
        
        addLocationViewModel.done
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.presentingViewController.dismiss(animated: true, completion: nil)
                self.parentCoordinator?.didFinish(coordinator: self)
            })
            .disposed(by: disposeBag)
    }
}

extension AddLocationCoordinator: AddLocationViewDelegate {

    public func updated(locations: [Location]) {
//        show(locations: locations)
     //   navigationController.dismiss(animated: true, completion: nil)
    }
    
    public func canceled() {
//        navigationController.dismiss(animated: true, completion: nil)
    }
}
