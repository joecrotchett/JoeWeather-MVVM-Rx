//
//  FileLocationDataStore.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
import PromiseKit

public class FileDataStore: LocationDataStore {

    let jsonFilename = "weatherData.json"
    
    var docsURL: URL? {
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                                         in: FileManager.SearchPathDomainMask.allDomainsMask).first
    }
    
    public init() {}
    
    public func getLocations() -> Promise<[Location]> {
        return Promise() { seal in
            guard let docsURL = docsURL else {
                seal.reject(WeatherError.any)
                return
            }
            guard let jsonData = try? Data(contentsOf: docsURL.appendingPathComponent(jsonFilename)) else {
                seal.fulfill([])
                return
            }
            let decoder = JSONDecoder()
            let locations = try! decoder.decode([Location].self, from: jsonData)
            seal.fulfill(locations)
        }
    }
    
    public func save(location: Location) -> Promise<[Location]> {
        return Promise { seal in
            self.getLocations().done { [weak self] locations in
                guard let self = self else {return}
                var updatedLocations = locations
                updatedLocations.append(location)
                let encoder = JSONEncoder()
                let jsonData = try! encoder.encode(updatedLocations)

                guard let docsURL = self.docsURL else {
                    seal.reject(WeatherError.any)
                    return
                }
                try? jsonData.write(to: docsURL.appendingPathComponent(self.jsonFilename))
                seal.fulfill(updatedLocations)
            }.cauterize()
        }
    }
    
    public func delete(location: Location) -> Promise<[Location]> {
        return Promise() { seal in
            self.getLocations().done { [weak self] locations in
                guard let self = self else {return}
                let updatedLocations = locations.filter{$0.zipCode != location.zipCode}
                let encoder = JSONEncoder()
                let jsonData = try! encoder.encode(updatedLocations)
                
                guard let docsURL = self.docsURL else {
                    seal.reject(WeatherError.any)
                    return
                }
                try? jsonData.write(to: docsURL.appendingPathComponent(self.jsonFilename))
                seal.fulfill(updatedLocations)
            }.cauterize()
        }
    }
}
