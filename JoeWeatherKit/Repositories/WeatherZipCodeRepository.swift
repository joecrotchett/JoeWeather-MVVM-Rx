//
//  File.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
import PromiseKit
import OpenWeatherKit

public class LocationRepository {
    
    let dataStore: LocationDataStore
    let weatherAPI: WeatherAPI

    public init(dataStore: LocationDataStore,
                weatherAPI: WeatherAPI) {
        self.dataStore = dataStore
        self.weatherAPI = weatherAPI
    }
    
    public func readLocations() -> Promise<[Location]> {
        return dataStore.getLocations()
    }
    
    public func add(zipCode: ZipCode) -> Promise<[Location]> {
        return firstly {
            self.weatherAPI.getForecast(for: zipCode)
        }.then { [weak self] (forecast) -> Promise<[Location]> in
            guard let self = self, let forecast = forecast else {
                return Promise(error: NSError(domain:"", code:0, userInfo:nil))
            }
            let location = Location(zipCode: zipCode, forecast: forecast)
            return self.dataStore.save(location:location)
        }
    }
    
    public func delete(location: Location) -> Promise<[Location]> {
        return  dataStore.delete(location: location)
    }
}
