//
//  ReusableView.swift
//  JoeWeatherUIKit
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit

public protocol ReusableView {
    static var reuseIdentifier: String { get }
}

public extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
