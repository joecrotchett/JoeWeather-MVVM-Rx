//
//  WelcomeViewModel.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation

public protocol WelcomeViewDelegate {
    func addLocation()
}

public final class WelcomeViewModel {
    
    private let locationRepository: LocationRepository
    private let delegate: WelcomeViewDelegate
    
    public init(locationRepository: LocationRepository, delegate: WelcomeViewDelegate) {
        self.delegate = delegate
        self.locationRepository = locationRepository
    }
    
    @objc
    public func addLocation() {
        self.delegate.addLocation()
    }
}
