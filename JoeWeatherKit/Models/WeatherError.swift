//
//  JoeWeatherError.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation

// In a real app, errors would be modeled here.
enum WeatherError: Error {
    case any
}

public struct ErrorMessage: Error {
    
    // MARK: - Properties
    public let id: UUID
    public let title: String
    public let message: String
    
    // MARK: - Methods
    public init(title: String, message: String) {
        self.id = UUID()
        self.title = title
        self.message = message
    }
}

extension ErrorMessage: Equatable {
    
    public static func ==(lhs: ErrorMessage, rhs: ErrorMessage) -> Bool {
        return lhs.id == rhs.id
    }
}
