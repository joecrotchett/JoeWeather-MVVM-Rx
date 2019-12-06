//
//  ForecastViewModel.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
import RxSwift
import OpenWeatherKit

public final class ForecastViewModel {
    
    public let location: Location
    
    public var navTitle: String {
        get {
            return location.zipCode
        }
    }
    
    public init(location: Location) {
        self.location = location
    }
    
    public func forecastDaysFromNow(day: Int) -> ForecastItem {
        // The forecast list contains indicies for every 3 hours
        // of the day. We multiplay 'day' by 8 to traverse the list
        // in increments of one day (8 * 3 = 24 hours).
        return location.forecast.list[day*8]
    }
}
