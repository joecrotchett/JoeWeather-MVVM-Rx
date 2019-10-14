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

public protocol LocationListViewDelegate {
    func listIsEmpty()
    func addLocation()
    func selected(location: Location)
}

public final class LocationListViewModel {
    
    // Dependencies
    private let delegate: LocationListViewDelegate
    private let locationRepository: LocationRepository
    
    // View State
    public let locations = BehaviorSubject<[Location]>(value: [])
    public var navTitle: String {
        get {
            return "Locations"
        }
    }
    
    public init(locations: [Location],
       locationRepository: LocationRepository,
                 delegate: LocationListViewDelegate) {
        self.delegate = delegate
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
        self.delegate.addLocation()
    }
    
    public func delete(location: Location) {
        self.locationRepository.delete(location: location)
            .done(indicateLocationsUpdated)
            .cauterize()
    }
    
    public func selected(location: Location) {
        self.delegate.selected(location: location)
    }
    
    // Private 
    private func update(locations: [Location]) {
        self.locations.onNext(locations)
    }
    
    private func indicateLocationsUpdated(_ locations: [Location]) {
        if locations.isEmpty {
            self.delegate.listIsEmpty()
        }
        self.update(locations: locations)
    }
}
