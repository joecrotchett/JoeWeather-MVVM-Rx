//
//  WelcomeViewModel.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
import RxSwift

public final class WelcomeViewModel {
    public let addLocationTapped = PublishSubject<Void>()
    
    public init() {}
}
