//
//  WeatherViewModel.swift
//  JoeWeatherKit
//
//  Created by Joe on 11/28/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
import RxSwift

public final class WeatherViewModel {
    
    private let locationRepository: LocationRepository
    public let locationsSubject = PublishSubject<[Location]>()
    public var locations: Observable<[Location]> {
        return locationsSubject.asObserver()
    }
    
    public init(locationRepository: LocationRepository) {
        self.locationRepository = locationRepository
    }
    
    
    public func readLocations() {
        locationRepository.readLocations().done { [weak self] locations in
            self?.locationsSubject.onNext(locations)
        }.cauterize()
    }
    
    //        productLoader.loadProduct(withID: productID) { [weak self] result in
    //            switch result {
    //            case .success(let product):
    //                self?.render(product)
    //            case .failure(let error):
    //                self?.render(error)
    //            }
    //        }
    //    }

    //    private func render(_ product: Product) {
    //        let contentVC = ProductContentViewController(product: product)
    //        stateViewController.transition(to: .render(contentVC))
    //    }
    //
    //    private func render(_ error: Error) {
    //        stateViewController.transition(to: .failed(error))
    //    }
}
