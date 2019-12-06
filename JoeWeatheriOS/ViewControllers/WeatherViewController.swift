//
//  WeatherViewController.swift
//  JoeWeatheriOS
//
//  Created by Joe on 11/28/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherUIKit
import JoeWeatherKit
import RxSwift

public final class WeatherViewController: NiblessViewController {
    
    private lazy var stateViewController = ContentStateViewController()
    private let disposeBag = DisposeBag()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        add(stateViewController)
    }
    
    public func render(contentVC: UIViewController) {
        stateViewController.transition(to: .render(contentVC))
    }

    public func render(_ error: Error) {
        stateViewController.transition(to: .failed(error))
    }
}
