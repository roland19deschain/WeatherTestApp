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
    private lazy var locationView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.isHidden = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapHandle(_:)))
        view.addGestureRecognizer(gesture)
        return view
    }()
    private lazy var textField: SkyFloatingLabelTextField = {
        let field = SkyFloatingLabelTextField()
        field.delegate = self
        field.placeholder = Translate.city
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
                self.locationView.isHidden = false
                self.addViewText(city)
            case .failure(let error): self.handleError?(error.rawValue)
            }
        }
    }
    
    private func addViewText(_ city: String) {
        let attrText = NSMutableAttributedString(string: Translate.youreLocation)
        attrText.append(.init(string: city, attributes: [.underlineStyle: 1,
                                                         .foregroundColor: UIColor.systemBlue]))
        attrText.append(.init(string: Translate.wantToShow))
        locationView.attributedText = attrText
        locationView.font = .boldSystemFont(ofSize: 20)
        locationView.textAlignment = .center
    }
    
    @objc private func tapHandle(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended:
            var text = locationView.text
            text!.removeFirst(Translate.youreLocation.count)
            text!.removeLast(Translate.wantToShow.count)
            showWeather?(text!)
        default:
            break
        }
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(locationView)
        addSubview(textField)
        addSubview(showButton)
        locationView.anchor(top: safeAreaLayoutGuide.topAnchor,
                            leading: leadingAnchor,
                            bottom: nil,
                            trailing: trailingAnchor,
                            padding: .init(top: 20, left: 30, bottom: 0, right: 30),
                            size: .init(width: 0, height: 70))
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

