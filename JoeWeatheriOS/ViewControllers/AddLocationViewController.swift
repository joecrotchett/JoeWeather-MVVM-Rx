//
//  AddLocationViewController.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import RxSwift
import JoeWeatherKit
import JoeWeatherUIKit

public final class AddLocationViewController: NiblessViewController {
    
    private let viewModel: AddLocationViewModel
    private let disposeBag = DisposeBag()
    
    public init(viewModel: AddLocationViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    public override func loadView() {
        view = AddLocationView(viewModel: self.viewModel)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        observeErrorMessages()
    }
    
    func observeErrorMessages() {
        viewModel
            .errorMessages
            .asDriver { _ in fatalError("Unexpected error from error messages observable.") }
            .drive(onNext: { [weak self] errorMessage in
                self?.present(errorMessage: errorMessage)
            })
            .disposed(by: disposeBag)
    }
}

