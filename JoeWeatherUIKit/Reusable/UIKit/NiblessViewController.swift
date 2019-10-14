//
//  NiblessViewController.swift
//  JoeWeatherUIKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit

open class NiblessViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable,
        message: "Loading this view controller from a nib is unsupported"
    )
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable,
        message: "Loading this view controller from a nib is unsupported"
    )
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported")
    }
}
