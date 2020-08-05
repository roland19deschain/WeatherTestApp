//
//  UIView+Layout.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

extension UIView {
    /// fill superview safe area by constraints
    func fillSuperview(padding: UIEdgeInsets) {
        guard let superview = superview else { return }
        anchor(top: superview.safeAreaLayoutGuide.topAnchor,
               leading: superview.safeAreaLayoutGuide.leadingAnchor,
               bottom: superview.safeAreaLayoutGuide.bottomAnchor,
               trailing: superview.safeAreaLayoutGuide.trailingAnchor,
               padding: padding)
    }
    
    /// sets constraints and size with constants
    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero)
    {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top { topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true }
        if let leading = leading { leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true }
        if let bottom = bottom { bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true }
        if let trailing = trailing { trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true }
        if size.width != 0 { widthAnchor.constraint(equalToConstant: size.width).isActive = true }
        if size.height != 0 { heightAnchor.constraint(equalToConstant: size.height).isActive = true }
    }
    
    /// sets center constraints position with constants
    func centring(xAnchor: NSLayoutXAxisAnchor?, constant xConstant: CGFloat = 0, yAnchor: NSLayoutYAxisAnchor?, constant yConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let xAnchor = xAnchor { centerXAnchor.constraint(equalTo: xAnchor, constant: xConstant).isActive = true }
        if let yAnchor = yAnchor { centerYAnchor.constraint(equalTo: yAnchor, constant: yConstant).isActive = true }
    }
    
    /// sets size constraints with multiplier
    func stretch(width: NSLayoutDimension?, multiplier widthMultiplier: CGFloat = 0, height: NSLayoutDimension?, multiplier heightMultiplier: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let width = width { widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier).isActive = true }
        if let height = height { heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier).isActive = true }
    }
}
