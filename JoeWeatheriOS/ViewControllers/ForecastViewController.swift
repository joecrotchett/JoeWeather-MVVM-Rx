//
//  ForecastViewController.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import JoeWeatherKit
import JoeWeatherUIKit

public final class ForecastViewController: NiblessViewController {
    
    private let viewModel: ForecastViewModel
    
    public init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    public override func loadView() {
        view = ForecastView(viewModel: self.viewModel)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    private func configureNavBar() {
        self.navigationItem.title = viewModel.navTitle
    }
}
