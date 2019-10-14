//
//  Coordinator.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherUIKit

public protocol Coodinator {
    var navigationController: UINavigationController { get set }
    func start()
}
