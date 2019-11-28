//
//  WeatherView.swift
//  JoeWeatheriOS
//
//  Created by Joe on 11/28/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherUIKit
import JoeWeatherKit

final class WeatherView: NiblessView {
    
    private var viewModel: WeatherViewModel
    private var hierarchyNotReady = true
    
    init(frame: CGRect = .zero,
     viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.backgroundColor = Color.red
    }
    
}
