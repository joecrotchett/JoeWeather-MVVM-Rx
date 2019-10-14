//
//  DayViewModel.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/6/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
import OpenWeatherKit

public final class DayViewModel {
    
    private let forecast: ForecastItem
    
    public init(forecast: ForecastItem) {
        self.forecast = forecast
    }
    
    public func temperature() -> String {
        let temp = Int(forecast.main.fahrenheit.maxTemp)
        return "\(temp)°F"
    }

    public func weekDay() -> String {
        let dateString = forecast.dt_txt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from:dateString!)
        return date!.dayOfWeek()!
    }
}

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        return dateFormatter.string(from: self).capitalized
    }
}

