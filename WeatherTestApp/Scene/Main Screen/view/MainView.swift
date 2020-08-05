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

final class MainView: UIView {
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    var showWeather: ((Observable<String?>) -> Void)?
    
    // MARK: - Views
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.borderStyle = .roundedRect
        field.placeholder = "Enter city"
        field
            .rx
            .text
            .orEmpty
            .subscribe({ self.showButton.isHidden = $0.element == "" ? true : false })
            .disposed(by: disposeBag)
        return field
    }()
    
    private lazy var showButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show weather", for: .normal)
        button
            .rx
            .tap
            .subscribe({ [weak self] _ in
                guard let self = self else { return }
                self.textField.resignFirstResponder()
                self.showWeather?(Observable.just(self.textField.text))
            })
            .disposed(by: disposeBag)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
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
