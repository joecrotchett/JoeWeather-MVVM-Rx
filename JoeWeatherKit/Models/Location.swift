//
//  Location.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
import OpenWeatherKit

public struct Location: Codable {
    public let zipCode: String
    public let forecast: ForecastItemsList
    public var weather: ForecastItem {
        get {
            return forecast.list[0]
        }
    }
    public var temperature: Int {
        get {
            return Int(weather.main.fahrenheit.currentTemp)
        }
    }
}
