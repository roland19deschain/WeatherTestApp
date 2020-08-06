//
//  CustomButton.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CustomButton: UIButton {
    private let disposeBag = DisposeBag()
    
    init(title: String, action: @escaping () -> Void) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        rx
            .tap
            .subscribe({ _ in action() })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
