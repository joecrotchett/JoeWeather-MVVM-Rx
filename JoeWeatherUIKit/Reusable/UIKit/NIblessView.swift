//
//  NIblessView.swift
//  JoeWeatherUIKit
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit

open class NiblessView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable,
        message: "Loading this view from a nib is unsupported"
    )
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported")
    }
}
