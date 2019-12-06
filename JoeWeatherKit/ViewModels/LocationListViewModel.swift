//
//  LocationListViewModel.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
import RxSwift
import OpenWeatherKit

public final class LocationListViewModel {
    
    // Dependencies
    private let locationRepository: LocationRepository
    
    // View State
    public let didTapAddLocation = PublishSubject<Void>()
    public let didSelectLocation = PublishSubject<Location>()
    public let locations = BehaviorSubject<[Location]>(value: [])
    public var navTitle: String {
        get {
            return "Locations"
        }
    }
    
    public init(locations: [Location],
       locationRepository: LocationRepository) {
        self.locationRepository = locationRepository
        update(locations: locations)
    }
    
    // View Actions
    public func refreshList() {
        self.locationRepository.readLocations()
            .done(update)
            .cauterize()
    }
    
    @objc
    public func addLocationTapped() {
        didTapAddLocation.onNext(())
    }
    
    public func delete(location: Location) {
        self.locationRepository.delete(location: location)
            .done(indicateLocationsUpdated)
            .cauterize()
    }
    
    // Private
    private func update(locations: [Location]) {
        self.locations.onNext(locations)
    }
    
    private func indicateLocationsUpdated(_ locations: [Location]) {
        self.update(locations: locations)
    }
}
