//
//  UIViewController+ErrorPresentation.swift
//  JoeWeatherUIKit
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import Foundation
import UIKit
import JoeWeatherKit

extension UIViewController {
    
    // MARK: - Methods
    public func present(errorMessage: ErrorMessage) {
        let errorAlertController = UIAlertController(title: errorMessage.title,
                                                   message: errorMessage.message,
                                            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        errorAlertController.addAction(okAction)
        present(errorAlertController, animated: true, completion: nil)
    }
}
