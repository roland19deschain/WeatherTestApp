//
//  MapState-protocol.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

protocol MapStateProtocol: UIView {
    var setDistance: ((Double, Double) -> Void)? { get set }
    init(lat: Double, lon: Double)
    func setPosition(lat: Double, lon: Double)
}
