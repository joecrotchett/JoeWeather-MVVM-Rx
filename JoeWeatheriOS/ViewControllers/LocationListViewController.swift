//
//  LocationListViewController.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherUIKit
import JoeWeatherKit

public final class LocationListViewController: NiblessViewController {
    
    private let viewModel: LocationListViewModel
    
    public init(viewModel: LocationListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    public override func loadView() {
        view = LocationListView(viewModel: self.viewModel)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    private func configureNavBar() {
        self.navigationItem.title = viewModel.navTitle
        let add = UIBarButtonItem(barButtonSystemItem: .add,
                                               target: viewModel,
                                               action: #selector(LocationListViewModel.addLocationTapped))
        add.tintColor = .white
        navigationItem.rightBarButtonItems = [add]
    }
}

