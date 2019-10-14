//
//  Color.swift
//  JoeWeatherUIKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit

public struct Color {
    public static let red = UIColor(0xFC5858)
    public static let white = UIColor(0xFFFFFF)
    public static let charcoal = UIColor(0x36454f)
    public static let lightButtonBackground = UIColor(0xFF8831)
    public static let darkTextColor = UIColor(0x23292B)
    public static let buttonText = UIColor(0xFF1B22)
}

extension UIColor {
    public convenience init(_ hex: Int) {
        assert(
            0...0xFFFFFF ~= hex,
            "UIColor+Hex: Hex value given to UIColor initializer should only include RGB values, i.e. the hex value should have six digits." //swiftlint:disable:this line_length
        )
        let red = (hex & 0xFF0000) >> 16
        let green = (hex & 0x00FF00) >> 8
        let blue = (hex & 0x0000FF)
        self.init(red: red, green: green, blue: blue)
    }
    
    public convenience init(red: Int, green: Int, blue: Int) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha:  1.0
        )
    }
}
