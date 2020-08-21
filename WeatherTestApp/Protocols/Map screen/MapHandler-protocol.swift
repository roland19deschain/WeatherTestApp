//
//  MapHandler-protocol.swift
//  WeatherTestApp
//
//  Created by User on 8/21/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation

protocol MapHandlerProtocol {
    var city: String { get }
    var type: Map { get }
    var coordinate: Coordinates { get }
    init(mapData: MapData)
}
