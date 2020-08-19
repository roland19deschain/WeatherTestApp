//
//  DistanceView.swift
//  WeatherTestApp
//
//  Created by User on 8/17/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

typealias DistanceData = (route: Double, line: Double)

final class DistanceView: UIView {
    var distanceData: DistanceData {
        get { return (0, 0) }
        
        set {
            routeDistanceLabel.text = "\(newValue.route) km"
            lineDistanceLabel.text = "\(newValue.line) km"
            UIView.transition(with: self,
                              duration: 0.5,
                              options: .transitionFlipFromBottom,
                              animations: { self.isHidden = false },
                              completion: nil)
        }
    }
    
    private let routeLabel = UILabel()
    private let lineLabel = UILabel()
    
    private let routeDistanceLabel = UILabel()
    private let lineDistanceLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        backgroundColor = .white
        layer.cornerRadius = 20
        routeLabel.text = "Route distance"
        lineLabel.text = "Line distance"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureStackLabels(isLeft: Bool, _ subviews: [UIView]) {
        subviews
            .map({ $0 as! UILabel })
            .forEach({
                $0.textAlignment = isLeft ? .left : .center
                
                $0.font = UIFont.preferredFont(forTextStyle: .largeTitle)
                $0.adjustsFontSizeToFitWidth = true
                $0.adjustsFontForContentSizeCategory = true
            })
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let leftStack = UIStackView(arrangedSubviews: [routeLabel, lineLabel])
        configureStackLabels(isLeft: true, leftStack.subviews)
        leftStack.distribution = .fillEqually
        leftStack.axis = .vertical
        
        let rightStack = UIStackView(arrangedSubviews: [routeDistanceLabel, lineDistanceLabel])
        configureStackLabels(isLeft: false, rightStack.subviews)
        rightStack.distribution = .fillEqually
        rightStack.axis = .vertical
        
        let stack = UIStackView(arrangedSubviews: [leftStack, rightStack])
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = 10
        addSubview(stack)
        stack.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        
    }
}
