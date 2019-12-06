//
//  AddLocationView.swift
//  JoeWeatheriOS
//
//  Created by Joe Crotchett on 4/18/19.
//  Copyright © 2019 Joe Crotchett. All rights reserved.
//

import UIKit
import RxSwift
import JoeWeatherUIKit
import JoeWeatherKit

final class AddLocationView: NiblessView {
    
    private var viewModel: AddLocationViewModel
    private let disposeBag = DisposeBag()
    private var hierarchyNotReady = true
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter a zip code"
        label.textColor = Color.red
        label.textAlignment = .center
        label.font = FontBook.SFProDisplayBold.of(size: 20)
        return label
    }()
    
    private let zipCodeField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.autocorrectionType = .no
        field.autocapitalizationType = .words
        field.textColor = .gray
        field.tintColor = .clear
        field.font = FontBook.SFProDisplayRegular.of(size: 42)
        field.textAlignment = .center
        field.keyboardType = .numberPad
        return field
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Save Location", for: .normal)
        button.backgroundColor = Color.red
        button.setTitleColor(Color.white, for: .normal)
        button.titleLabel?.font = FontBook.SFProDisplayHeavy.of(size: 12)
        button.layer.cornerRadius = 15
        button.layer.shadowRadius = 3.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        button.isHidden = true
        return button
    }()
    
    private let cancelButton: UIButton = {
        let addImage = UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom)
        button.setImage(addImage, for: UIControl.State.normal)
        button.tintColor = Color.red
        button.heightAnchor
            .constraint(equalToConstant: 25)
            .isActive = true
        button.widthAnchor
            .constraint(equalToConstant: 25)
            .isActive = true
        return button
    }()
    
    init(frame: CGRect = .zero,
         viewModel: AddLocationViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        self.backgroundColor = Color.white
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else { return }
        
        constructHierarchy()
        activateConstraints()
        bindViewModel()
        hierarchyNotReady = false
        
        self.zipCodeField.delegate = self
        self.zipCodeField.becomeFirstResponder()
    }
    
    private func bindViewModel() {
        saveButton.addTarget(viewModel, action: #selector(AddLocationViewModel.save), for: .touchUpInside)
        
        zipCodeField.rx.text
            .asDriver()
            .map { $0 ?? "" }
            .drive(viewModel.zipCodeInput)
            .disposed(by: disposeBag)
        
        saveButton.rx.controlEvent([.touchUpInside])
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.zipCodeField.resignFirstResponder()
            }).disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .bind(to: viewModel.cancel)
            .disposed(by: disposeBag)
    }
    
    private func constructHierarchy() {
        self.addSubview(self.headerLabel)
        self.addSubview(self.zipCodeField)
        self.addSubview(self.saveButton)
        self.addSubview(self.cancelButton)
    }
    
    private func activateConstraints() {
        activateHeaderLabelConstraints()
        activateZipCodeFieldConstraints()
        activateSaveButtonConstraints()
        activateCancelButtonConstraints()
    }
    
    private func activateHeaderLabelConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leadingAnchor
            .constraint(equalTo: layoutMarginsGuide.leadingAnchor)
            .isActive = true
        headerLabel.trailingAnchor
            .constraint(equalTo: layoutMarginsGuide.trailingAnchor)
            .isActive = true
        headerLabel.topAnchor
            .constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 75)
            .isActive = true
        headerLabel.heightAnchor
            .constraint(equalToConstant: 50)
            .isActive = true
    }
    
    private func activateZipCodeFieldConstraints() {
        zipCodeField.translatesAutoresizingMaskIntoConstraints = false
        zipCodeField.leadingAnchor
            .constraint(equalTo: layoutMarginsGuide.leadingAnchor)
            .isActive = true
        zipCodeField.trailingAnchor
            .constraint(equalTo: layoutMarginsGuide.trailingAnchor)
            .isActive = true
        zipCodeField.topAnchor
            .constraint(equalTo: headerLabel.topAnchor, constant: 50)
            .isActive = true
        zipCodeField.heightAnchor
            .constraint(equalToConstant: 50)
            .isActive = true
    }
    
    private func activateSaveButtonConstraints() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor
            .constraint(equalTo: self.centerXAnchor)
            .isActive = true
        saveButton.topAnchor
            .constraint(equalTo: self.zipCodeField.bottomAnchor, constant: 20)
            .isActive = true
        saveButton.widthAnchor
            .constraint(equalToConstant: 150)
            .isActive = true
        saveButton.heightAnchor
            .constraint(equalToConstant: 30)
            .isActive = true
    }
    
    private func activateCancelButtonConstraints() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.leadingAnchor
            .constraint(equalTo: layoutMarginsGuide.leadingAnchor)
            .isActive = true
        safeAreaLayoutGuide.topAnchor
            .constraint(equalTo: cancelButton.topAnchor, constant: -10)
            .isActive = true
    }
}

extension AddLocationView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        if count < 5 {
            saveButton.isHidden = true
            return true
        }
        else if count == 5 {
            saveButton.isHidden = false
            return true
        }
        else {
            return false
        }
    }
}
