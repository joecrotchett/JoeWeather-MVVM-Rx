//
//  WelcomeViewController.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import JoeWeatherKit
import JoeWeatherUIKit

public final class WelcomeViewController: NiblessViewController {
    
    private let viewModel: WelcomeViewModel
    
    public init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    public override func loadView() {
        view = WelcomeView(viewModel: self.viewModel)
    }
}
