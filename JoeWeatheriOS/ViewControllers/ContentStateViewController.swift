//
//  ContentStateViewController.swift
//  JoeWeatheriOS
//
//  Created by Joe on 11/28/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherUIKit

class ContentStateViewController: NiblessViewController {
    private var state: State?
    private var shownViewController: UIViewController?

    func transition(to newState: State) {
        shownViewController?.remove()
        let vc = viewController(for: newState)
        add(vc)
        shownViewController = vc
        state = newState
    }
}

private extension ContentStateViewController {
    func viewController(for state: State) -> UIViewController {
        switch state {
        case .loading:
            return LoadingViewController()
        case .failed(let error):
            return ErrorViewController(error: error)
        case .render(let viewController):
            return viewController
        }
    }
}

extension ContentStateViewController {
    enum State {
        case loading
        case failed(Error)
        case render(UIViewController)
    }
}
