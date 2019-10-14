//
//  WeatherAPI.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
import PromiseKit
import OpenWeatherKit

public class OpenWeatherAPI: WeatherAPI {
    
    let openWeather: OpenWeatherMapKit
    
    public init(openWeather: OpenWeatherMapKit) {
        self.openWeather = openWeather
    }
    
    public func getForecast(for zipCode: ZipCode) -> Promise<ForecastItemsList?> {
        return Promise() { [weak self] seal in
            self?.openWeather.weatherForecastForFiveDays(forZipCode: zipCode, callback: { (forecast, error) in
                guard let forecast = forecast else {
                    seal.fulfill(nil)
                    return
                }
                seal.fulfill(forecast)
            })
        }
    }
}
