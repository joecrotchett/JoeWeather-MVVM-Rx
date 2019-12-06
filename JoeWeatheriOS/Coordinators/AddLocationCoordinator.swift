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
    
    public override func start() -> Observable<Result<[Location]?, Error>> {
        let addLocationViewModel = mainFactory.makeAddLocationViewModel(with: self)
        let addLocationViewController = mainFactory.makeAddLocationViewController(with: addLocationViewModel)
        self.presentingViewController.present(addLocationViewController, animated: true, completion: nil)
        
        let cancel = addLocationViewModel.cancel.map { _ in Result<[Location]?, Error>.success(nil) }
        let locationAdded = addLocationViewModel.locationAdded.map { Result<[Location]?, Error>.success($0) }
        
        return Observable.merge(cancel, locationAdded)
            .take(1)
            .do(onNext: { [weak self] _ in self?.presentingViewController.dismiss(animated: true, completion: nil) })
        
//        return addLocationViewModel.done.asObservable()
//            .subscribe(onNext: { [weak self] in
//                guard let self = self else { return }
//                self.presentingViewController.dismiss(animated: true, completion: nil)
////                self.parentCoordinator?.didFinish(coordinator: self)
//            })
//            .disposed(by: disposeBag)
        
        //return Observable.never()
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
