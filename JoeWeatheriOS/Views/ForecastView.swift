//
//  ForecastView.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherUIKit
import JoeWeatherKit

final class ForecastView: NiblessView {
    
    private var viewModel: ForecastViewModel
    private var hierarchyNotReady = true
    
    private let gradientImageView: UIImageView = {
        let image = UIImage(named: "bg-gradient")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let image = UIImage(named: "joe-weather-logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "five day forecast"
        label.textColor = .white
        label.textAlignment = .center
        label.font = FontBook.LoversQuarrelRegular.of(size: 50)
        label.shadowColor = .lightText
        label.shadowOffset = CGSize(width: 1, height: 1)
        return label
    }()
    
    private let forecastStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    init(frame: CGRect = .zero,
         viewModel: ForecastViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.backgroundColor = Color.red
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else { return }
        
        constructHierarchy()
        activateConstraints()
        hierarchyNotReady = false
    }
    
    //MARK: View layout
    
    private func constructHierarchy() {
        addSubview(gradientImageView)
        addSubview(logoImageView)
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(headerLabel)
        containerStackView.addArrangedSubview(forecastStackView)
        
        for day in 0...4 {
            let forecast = viewModel.forecastDaysFromNow(day: day)
            let dayViewModel = DayViewModel(forecast: forecast)
            let dayView = DayView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), viewModel: dayViewModel)
            forecastStackView.addArrangedSubview(dayView)
        }
    }
    
    private func activateConstraints() {
        activateGradientConstraints()
        activateContainerConstraints()
        activateLogoConstraints()
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
        containerStackView.leadingAnchor
            .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30)
            .isActive = true
        containerStackView.trailingAnchor
            .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30)
            .isActive = true
        containerStackView.heightAnchor
            .constraint(equalToConstant: 150)
            .isActive = true
        containerStackView.centerXAnchor
            .constraint(equalTo: self.centerXAnchor)
            .isActive = true
        containerStackView.centerYAnchor
            .constraint(equalTo: self.centerYAnchor)
            .isActive = true
    }
    
    private func activateLogoConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.bottomAnchor
            .constraint(equalTo: containerStackView.topAnchor, constant: 8)
            .isActive = true
        logoImageView.centerXAnchor
            .constraint(equalTo: self.centerXAnchor)
            .isActive = true
        logoImageView.widthAnchor
            .constraint(equalToConstant: 240)
            .isActive = true
        logoImageView.heightAnchor
            .constraint(equalToConstant: 128)
            .isActive = true
    }
}
