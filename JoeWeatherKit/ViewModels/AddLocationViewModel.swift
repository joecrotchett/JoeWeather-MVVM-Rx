//
//  AddLocationViewModel.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
import RxSwift

public protocol AddLocationViewDelegate {
    func updated(locations: [Location])
    func canceled()
}

public final class AddLocationViewModel {
    
    // View Dependencies
    private let delegate: AddLocationViewDelegate
    private let locationRepository: LocationRepository
    
    // View State
    public let zipCodeInput = BehaviorSubject<String>(value: "")
    public let errorMessagesSubject = PublishSubject<ErrorMessage>()
    public var errorMessages: Observable<ErrorMessage> {
        return errorMessagesSubject.asObserver()
    }
    
    // Initializers
    public init(locationRepository: LocationRepository, delegate: AddLocationViewDelegate) {
        self.delegate = delegate
        self.locationRepository = locationRepository
    }
    
    // View Actions
    @objc
    public func save() {
        do {
            let zipCode = try zipCodeInput.value()
            self.locationRepository.add(zipCode: zipCode)
            .done(indicateLocationsUpdated)
            .catch(indicateErrorAddingLocation)
        } catch {
            fatalError("Error reading zip code from behavior subjects.")
        }
    }
    
    @objc
    public func cancel() {
        self.delegate.canceled()
    }
    
    // Private
    private func indicateLocationsUpdated(_ locations: [Location]) {
        self.delegate.updated(locations: locations)
    }
    
    private func indicateErrorAddingLocation(_ error: Error) {
        errorMessagesSubject.onNext(ErrorMessage(title: "Error Adding Zip Code",
                                               message: "Please enter a valid zip code"))
    }
}
