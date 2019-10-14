//
//  RESTAPI.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
import PromiseKit
import OpenWeatherKit

public protocol WeatherAPI {
    func getForecast(for zipCode: ZipCode) -> Promise<ForecastItemsList?>
}
