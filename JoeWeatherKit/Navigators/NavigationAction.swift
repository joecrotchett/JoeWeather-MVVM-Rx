//
//  NavigationAction.swift
//  JoeWeatherKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation

public enum NavigationAction<ViewModelType>: Equatable where ViewModelType: Equatable {
    case present(view: ViewModelType)
    case presented(view: ViewModelType)
}
