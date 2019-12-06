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

public final class AddLocationCoordinator: BaseCoordinator<Result<[Location]?, Error>> {
    
    private let presentingViewController: NiblessViewController
    private let locationRepository: LocationRepository
    private let disposeBag = DisposeBag()
    
    public init(with presentingViewController: NiblessViewController,
                           locationRepository: LocationRepository) {
        self.presentingViewController = presentingViewController
        self.locationRepository = locationRepository
    }
    
    public override func start() -> Observable<Result<[Location]?, Error>> {
        let addLocationViewModel = AddLocationViewModel(locationRepository: locationRepository)
        let addLocationViewController = AddLocationViewController(viewModel: addLocationViewModel)
        self.presentingViewController.present(addLocationViewController, animated: true, completion: nil)
        
        let cancel = addLocationViewModel.cancel.map { _ in Result<[Location]?, Error>.success(nil) }
        let locationAdded = addLocationViewModel.locationAdded.map { Result<[Location]?, Error>.success($0) }
        
        return Observable.merge(cancel, locationAdded)
            .take(1)
            .do(onNext: { [weak self] _ in self?.presentingViewController.dismiss(animated: true, completion: nil)
        })
    }
}
