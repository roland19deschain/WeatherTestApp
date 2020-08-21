//
//  MapHandler.swift
//  WeatherTestApp
//
//  Created by User on 8/21/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation

final class MapHandler: MapHandlerProtocol {
    private let mapData: MapData
    var city: String { mapData.city }
    var type: Map { mapData.type }
    var coordinate: Coordinates { (mapData.lat, mapData.lon) }
    
    init(mapData: MapData) { self.mapData = mapData }
}
