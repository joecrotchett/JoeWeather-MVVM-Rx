//
//  WelcomeView.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherUIKit
import JoeWeatherKit

final class WelcomeView: NiblessView {
    
    private var viewModel: WelcomeViewModel
    private var hierarchyNotReady = true
    
    private let gradientImageView: UIImageView = {
        let image = UIImage(named: "bg-gradient")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let logoImageView: UIImageView = {
        let image = UIImage(named: "joe-weather-logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 7
        return stackView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Nothing to see here!"
        label.textColor = .white
        label.textAlignment = .center
        label.font = FontBook.SFProDisplayBold.of(size: 20)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "How about we start by adding a location"
        label.textColor = .white
        label.textAlignment = .center
        label.font = FontBook.SFProDisplayRegular.of(size: 14)
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Add Location", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(Color.buttonText, for: .normal)
        button.titleLabel?.font = FontBook.SFProDisplayHeavy.of(size: 12)
        button.layer.cornerRadius = 15
        button.layer.shadowRadius = 3.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 0.8
        button.layer.masksToBounds = false
        return button
    }()
    
    init(frame: CGRect = .zero,
         viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.backgroundColor = Color.red
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else { return }
        
        constructHierarchy()
        activateConstraints()
        bindViewModel()
        hierarchyNotReady = false
    }
    
    //MARK: View layout
    
    private func constructHierarchy() {
        addSubview(gradientImageView)
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(logoImageView)
        containerStackView.addArrangedSubview(labelStackView)
        containerStackView.addArrangedSubview(addButton)
        
        labelStackView.addArrangedSubview(headerLabel)
        labelStackView.addArrangedSubview(bodyLabel)
    }
    
    private func activateConstraints() {
        activateGradientConstraints()
        activateContainerConstraints()
        activateLogoConstraints()
        activateLabelStackConstraints()
        activateButtonConstraints()
    }
    
    private func activateGradientConstraints() {
        gradientImageView.translatesAutoresizingMaskIntoConstraints = false
        gradientImageView.leadingAnchor
            .constraint(equalTo: self.leadingAnchor)
            .isActive = true
        gradientImageView.trailingAnchor
            .constraint(equalTo: self.trailingAnchor)
            .isActive = true
        gradientImageView.topAnchor
            .constraint(equalTo: self.topAnchor)
            .isActive = true
        gradientImageView.bottomAnchor
            .constraint(equalTo: self.bottomAnchor)
            .isActive = true
    }
    
    private func activateContainerConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.centerXAnchor
            .constraint(equalTo: self.centerXAnchor)
            .isActive = true
        containerStackView.centerYAnchor
            .constraint(equalTo: self.centerYAnchor)
            .isActive = true
    }
    
    private func activateLogoConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor
            .constraint(equalToConstant: 300)
            .isActive = true
        logoImageView.heightAnchor
            .constraint(equalToConstant: 112)
            .isActive = true
    }
    
    private func activateLabelStackConstraints() {
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.widthAnchor
            .constraint(equalToConstant: 233)
            .isActive = true
        labelStackView.heightAnchor
            .constraint(equalToConstant: 48)
            .isActive = true
    }
    
    private func activateButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.widthAnchor
            .constraint(equalToConstant: 150)
            .isActive = true
        addButton.heightAnchor
            .constraint(equalToConstant: 30)
            .isActive = true
    }
    
    //MARK: Actions
    private func bindViewModel() {
        addButton.addTarget(viewModel, action: #selector(WelcomeViewModel.addLocation),for: .touchUpInside)
    }
}
