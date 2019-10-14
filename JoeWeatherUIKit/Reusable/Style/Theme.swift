//
//  Theme.swift
//  JoeWeatherUIKit
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit

public struct Theme {
    public static func apply(to window: UIWindow) {
        window.tintColor = Color.red
        window.backgroundColor = Color.red
        
        let textShadow = NSShadow()
        textShadow.shadowBlurRadius = 3
        textShadow.shadowOffset = CGSize(width: 1, height: 1)
        textShadow.shadowColor = UIColor.gray
        
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = Color.red
        navBar.tintColor = .white
        navBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : Color.white,
            NSAttributedString.Key.font : FontBook.SFProDisplayBold.of(size: 17)]
        
    }
}
