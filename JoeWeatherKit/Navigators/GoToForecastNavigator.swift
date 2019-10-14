//
//  GoToForecastNavigator.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
//import RxSwift

public protocol AppNavigator {
    func navigateToLocationList()
    func navigateToForecast(zipcode: String)
    func navigateToAddLocation()
}
