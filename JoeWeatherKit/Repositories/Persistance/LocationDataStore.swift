//
//  LocationDataStore.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
import PromiseKit

public typealias ZipCode = String
public typealias Temperature = Int

public protocol LocationDataStore {
    func getLocations() -> Promise<[Location]>
    func save(location: Location) -> Promise<[Location]>
    func delete(location: Location) -> Promise<[Location]>
}
