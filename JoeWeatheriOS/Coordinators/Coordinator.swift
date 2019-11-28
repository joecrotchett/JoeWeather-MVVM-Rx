//
//  Coordinator.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherUIKit

public protocol Coordinator {
    var window: UIWindow { get set }
    func start()
}
