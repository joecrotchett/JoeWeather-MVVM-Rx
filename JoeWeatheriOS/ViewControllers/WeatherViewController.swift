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

//public protocol WeatherViewControllerDelegate {
//    func weatherViewController(_ sender: WeatherViewController,
//                    didUpdate locations: [Location])
//}

public final class WeatherViewController: NiblessViewController {
    
    private lazy var stateViewController = ContentStateViewController()
    private let viewModel: WeatherViewModel
    private let disposeBag = DisposeBag()
//    private let delegate: WeatherViewControllerDelegate
    
    public init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
//        self.delegate = delegate
        super.init()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        add(stateViewController)
//        observeViewState()
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        viewModel.readLocations()
    }
    
//    func observeViewState() {
//        viewModel
//            .locations
//            .asDriver { _ in fatalError("Unexpected error from locations observable.") }
//            .drive(onNext: { [weak self] locations in
//                guard let self = self else { return }
//                self.delegate.weatherViewController(self, didUpdate: locations)
//            })
//            .disposed(by: disposeBag)
//    }
    
    public func render(contentVC: UIViewController) {
        stateViewController.transition(to: .render(contentVC))
    }

    public func render(_ error: Error) {
        stateViewController.transition(to: .failed(error))
    }
}
