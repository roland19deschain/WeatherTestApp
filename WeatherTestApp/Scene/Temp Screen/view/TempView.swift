//
//  TempView.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

final class TempView: UIView {
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Helper
    func setLabelText(temp: String?, description: String?) {
        let attrString = NSMutableAttributedString(string: (temp ?? "") + "℃", attributes: [.font: UIFont.boldSystemFont(ofSize: 70)])
        attrString.append(NSAttributedString(string: "\n" + (description ?? ""), attributes: [.foregroundColor: UIColor.red]))
        tempLabel.attributedText = attrString
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(tempLabel)
        tempLabel.centring(xAnchor: centerXAnchor, yAnchor: centerYAnchor)
        tempLabel.stretch(width: widthAnchor, multiplier: 0.9, height: widthAnchor, multiplier: 0.9)
    }
    
}
