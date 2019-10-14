//
//  LocationCell.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/22/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import JoeWeatherUIKit
import JoeWeatherKit

final class LocationCell: UITableViewCell {
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let ZipLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = FontBook.SFProDisplayBold.of(size: 20)
        label.backgroundColor = Color.red
        return label
    }()
    
    private let TemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = FontBook.SFProDisplayRegular.of(size: 14)
        label.backgroundColor = Color.red
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureHeirarchy()
        configureConstraints()
    }
    
    private func configureCell() {
        self.backgroundColor = Color.red
        let bgColorView = UIView()
        bgColorView.backgroundColor = Color.red
        selectedBackgroundView = bgColorView
        accessoryType = .disclosureIndicator
        tintColor = Color.white
    }
    
    private func configureHeirarchy() {
        contentView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(ZipLabel)
        labelStackView.addArrangedSubview(TemperatureLabel)
    }
    
    private func configureConstraints() {
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor, constant: 20)
            .isActive = true
        labelStackView.trailingAnchor
            .constraint(equalTo: contentView.trailingAnchor, constant: -20)
            .isActive = true
        labelStackView.topAnchor
            .constraint(equalTo: contentView.topAnchor)
            .isActive = true
        labelStackView.bottomAnchor
            .constraint(equalTo: contentView.bottomAnchor)
            .isActive = true
    }
    
    public func configure(with location: Location) {
        ZipLabel.text = location.zipCode
        TemperatureLabel.text = "\(location.temperature)°F"
    }
}
