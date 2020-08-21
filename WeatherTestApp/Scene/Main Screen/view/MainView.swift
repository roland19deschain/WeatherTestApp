//
//  MainView.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SkyFloatingLabelTextField
import SwiftValidator

final class MainView: UIView {
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let validator = Validator()
    var showWeather: ((String) -> Void)?
    var handleError: ((String) -> Void)?
    
    // MARK: - Views
    private var locationButton: UIButton!
    private lazy var textField: SkyFloatingLabelTextField = {
        let field = SkyFloatingLabelTextField()
        field.delegate = self
        field.placeholder = "City"
        field.title = Translate.enterCity
        field.selectedTitleColor = .systemBlue
        field.lineColor = .systemBlue
        field.addTarget(self, action: #selector(textFieldHandleError(_:)), for: .editingChanged)
        return field
    }()
    private lazy var showButton = CustomButton(title: Translate.showWeather) { [weak self] in
        guard let self = self else { return }
        self.textField.resignFirstResponder()
        self.showWeather?(self.textField.text ?? "")
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        showButton.isHidden = true
        validator.registerField(textField, errorLabel: showButton.titleLabel, rules: [RequiredRule(), ThreeSpaceRule(), MinLengthRule(length: 2)])
        configureButton()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Configure
    @objc private func textFieldHandleError(_ textField: SkyFloatingLabelTextField) {
        showButton.isHidden = false
        validator.validate(self)
    }
    
    private func configureButton() {
        LocationService.shared.result = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let city):
                let title = "Your location is \(city), what to show?"
                self.locationButton = CustomButton(title: title, action: { self.showWeather?(city) })
                self.setupLocationButton()
            case .failure(let error): self.handleError?(error.rawValue)
            }
        }
    }
    
    private func setupLocationButton() {
        addSubview(locationButton)
        locationButton.anchor(top: safeAreaLayoutGuide.topAnchor,
                              leading: leadingAnchor,
                              bottom: nil,
                              trailing: trailingAnchor,
                              padding: .init(top: 20, left: 30, bottom: 0, right: 30),
                              size: .init(width: 0, height: 70))
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(textField)
        addSubview(showButton)
        textField.centring(xAnchor: centerXAnchor, yAnchor: centerYAnchor)
        textField.anchor(top: nil,
                         leading: leadingAnchor,
                         bottom: nil,
                         trailing: trailingAnchor,
                         padding: .init(top: 0, left: 20, bottom: 0, right: 20),
                         size: .init(width: 0, height: 50))
        showButton.anchor(top: textField.bottomAnchor,
                           leading: textField.leadingAnchor,
                           bottom: nil,
                           trailing: textField.trailingAnchor,
                           padding: .init(top: 20, left: 0, bottom: 0, right: 0),
                           size: .init(width: 0, height: 50))
        
    }
    
}

// MARK: - Text Field delegate
extension MainView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

// MARK: - Validator delegate
extension MainView: ValidationDelegate {
    func validationSuccessful() {
        showButton.setTitle(Translate.showWeather, for: .normal)
        showButton.setTitleColor(.systemBlue, for: .normal)
        showButton.isEnabled = true
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (_, error) in errors {
            showButton.setTitle(error.errorMessage, for: .normal)
            showButton.setTitleColor(.red, for: .normal)
            showButton.isEnabled = false
        }
    }
}

