//
//  TempHandler-protocol.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation

protocol TempHandlerProtocol {
    var title: String { get }
    var temp: String { get }
    var description: String { get }
    var lat: Double { get }
    var lon: Double { get }
    init(response: WeatherResponse, router: RouterProtocol)
    func pushToMap(mapData: MapData)
}
