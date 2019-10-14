//
//  OpenWeatherMapKit.swift
//  OpenWeatherMapKit
//
//  Created by Anver Bogatov on 22.12.2017.
//  Copyright © 2017 Anver Bogatov. All rights reserved.
//

import Foundation

/// OpenWeatherMapKit main class. Use it for access weather data
/// for any geo location you need.
public class OpenWeatherMapKit {

    /// API token that should be set during initialization
    private static var token: String?

    /// Main kit's instance.
    public static let instance = OpenWeatherMapKit()

    /// Private initializer. Must not be invoked from outside
    private init() {
    }

    /// Initialize main framework class with OpenWeatherMap service's API token.
    ///
    /// - Parameter token: API key that should be retrieved from https://openweathermap.org
    public class func initialize(withAppId token: String) {
        self.token = token
    }

    /// Request current weather for provided geographical coordinate.
    ///
    /// - Parameters:
    ///   - coord: geo coordinate as a tuple with $0=latitude and $1=longitude
    ///   - callback: closure that will be invoked as the result of API call
    public func currentWeather(forCoordiante coord: (latitude: Double, longitude: Double),
                               callback: @escaping (ForecastItem?, Error?) -> ()) {
        NetworkManager.instance.get(from:
            RequestBuilder()
                .setToken(token: OpenWeatherMapKit.token)
                .setWeatherMode(mode: .current)
                .setLatitude(lat: coord.latitude)
                .setLongitude(lon: coord.longitude)
                .build(),
                                    callback: callback)
    }

    /// Request current weather for provided city (by name and [optional] country code).
    ///
    /// - Parameters:
    ///   - city: name of the city
    ///   - countryCode: optional geo code of the country
    ///   - callback: closure that will be invoked as the result of API call
    public func currentWeather(forCity city: String,
                               withCountryCode countryCode: String? = nil,
                               callback: @escaping (ForecastItem?, Error?) -> ()) {
        NetworkManager.instance.get(from:
            RequestBuilder()
                .setToken(token: OpenWeatherMapKit.token)
                .setWeatherMode(mode: .current)
                .setCity(city: city)
                .setCountryCode(code: countryCode)
                .build(),
                                    callback: callback)
    }
    
    /// Request current weather for provided zip
    ///
    /// - Parameters:
    ///   - zip: zip code
    ///   - countryCode: optional geo code of the country
    ///   - callback: closure that will be invoked as the result of API call
    public func currentWeather(forZipCode zipCode: String,
                               withCountryCode countryCode: String? = nil,
                               callback: @escaping (ForecastItem?, Error?) -> ()) {
        NetworkManager.instance.get(from:
            RequestBuilder()
                .setToken(token: OpenWeatherMapKit.token)
                .setWeatherMode(mode: .current)
                .setZip(zip: zipCode)
                .setCountryCode(code: countryCode)
                .build(),
                                    callback: callback)
    }

    /// Request weather forecast on next 5 days for provided geographical coordinate.
    ///
    /// - Parameters:
    ///   - coord: geo coordinate as a tuple with $0=latitude and $1=longitude
    ///   - callback: closure that will be invoked as the result of API call
    public func weatherForecastForFiveDays(forCoordiante coord: (latitude: Double, longitude: Double),
                                           callback: @escaping (ForecastItemsList?, Error?) -> ()) {
        NetworkManager.instance.get(from:
            RequestBuilder()
                .setToken(token: OpenWeatherMapKit.token)
                .setWeatherMode(mode: .fiveDays)
                .setLatitude(lat: coord.latitude)
                .setLongitude(lon: coord.longitude)
                .build(),
                                    callback: callback)
    }

    /// Request weather forecast on next 5 days for provided city (by name and [optional] country code).
    ///
    /// - Parameters:
    ///   - city: name of the city
    ///   - countryCode: optional geo code of the country
    ///   - callback: closure that will be invoked as the result of API call
    public func weatherForecastForFiveDays(forCity city: String,
                                           withCountryCode countryCode: String? = nil,
                                           callback: @escaping (ForecastItemsList?, Error?) -> ()) {
        NetworkManager.instance.get(from:
            RequestBuilder()
                .setToken(token: OpenWeatherMapKit.token)
                .setWeatherMode(mode: .fiveDays)
                .setCity(city: city)
                .setCountryCode(code: countryCode)
                .build(),
                                    callback: callback)
    }
    
    /// Request weather forecast on next 5 days for provided city (by name and [optional] country code).
    ///
    /// - Parameters:
    ///   - city: name of the city
    ///   - countryCode: optional geo code of the country
    ///   - callback: closure that will be invoked as the result of API call
    public func weatherForecastForFiveDays(forZipCode: String,
                                           withCountryCode countryCode: String? = nil,
                                           callback: @escaping (ForecastItemsList?, Error?) -> ()) {
        NetworkManager.instance.get(from:
            RequestBuilder()
                .setToken(token: OpenWeatherMapKit.token)
                .setWeatherMode(mode: .fiveDays)
                .setZip(zip: forZipCode)
                .setCountryCode(code: countryCode)
                .build(),
                                    callback: callback)
    }
}
