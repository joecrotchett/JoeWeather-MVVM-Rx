//
//  UITableView+ReusableView.swift
//  JoeWeatherUIKit
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit

extension UITableViewCell : ReusableView { }

public extension UITableView {
    func dequeue<T : UITableViewCell>(for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath)
        return cell as! T
    }
}
