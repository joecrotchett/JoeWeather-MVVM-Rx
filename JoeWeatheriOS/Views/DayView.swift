//
//  DayView.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/6/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherUIKit
import JoeWeatherKit

final class DayView: UIStackView {
    
    private var viewModel: DayViewModel
    private var hierarchyNotReady = true
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Day 1"
        label.textColor = .lightText
        label.textAlignment = .center
        label.font = FontBook.SFProDisplayBold.of(size: 12)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "58°F"
        label.textColor = .white
        label.textAlignment = .center
        label.font = FontBook.SFProDisplayHeavy.of(size: 20)
        return label
    }()
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported")
    }
    
    init(frame: CGRect = .zero,
     viewModel: DayViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else { return }
        axis = .vertical
        constructHierarchy()
        hierarchyNotReady = false
    }
    
    //MARK: View layout
    
    private func constructHierarchy() {
        addArrangedSubview(headerLabel)
        addArrangedSubview(bodyLabel)
        
        headerLabel.text = viewModel.weekDay()
        bodyLabel.text = viewModel.temperature()
    }
}
