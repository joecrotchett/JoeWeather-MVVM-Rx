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
    private var state: ContentState?
    private var shownViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if state == nil {
            transition(to: .loading)
        }
    }

    func transition(to newState: ContentState) {
        shownViewController?.remove()
        let vc = viewController(for: newState)
        add(vc)
        shownViewController = vc
        state = newState
    }
}

private extension ContentStateViewController {
    func viewController(for state: ContentState) -> UIViewController {
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
    enum ContentState {
        case loading
        case failed(Error)
        case render(UIViewController)
    }
}
