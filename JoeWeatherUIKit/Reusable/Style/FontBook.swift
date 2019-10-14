//
//  FontBook.swift
//  JoeWeather
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit

public enum FontBook: String {
    case LoversQuarrelRegular = "LoversQuarrel-Regular"
    case SFProDisplayRegular = "SFProDisplay-Regular"
    case SFProDisplayBold = "SFProDisplay-Bold"
    case SFProDisplayHeavy = "SFProDisplay-Heavy"
    
    public func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}
