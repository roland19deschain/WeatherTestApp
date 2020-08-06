//
//  TempView.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

enum Map { case apple, google }

final class TempView: UIView {
    var mapAction: ((Map) -> Void)?
    
    // MARK: - Views
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var mapButton = CustomButton(title: Constants.map, action: { self.mapAction?(.apple) })
    private lazy var googleMapButton = CustomButton(title: Constants.googleMap, action: { self.mapAction?(.google) })
    
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
        
        let buttonsStack = UIStackView(arrangedSubviews: [mapButton, googleMapButton])
        buttonsStack.distribution = .fillEqually
        addSubview(buttonsStack)
        buttonsStack.anchor(top: tempLabel.bottomAnchor,
                            leading: tempLabel.leadingAnchor,
                            bottom: nil,
                            trailing: tempLabel.trailingAnchor,
                            padding: .init(top: 20, left: 0, bottom: 0, right: 0),
                            size: .init(width: 0, height: 60))
    }
    
}
