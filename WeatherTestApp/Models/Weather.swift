//
//  Weather.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let coord: Coord
    let weather: [Description]
    let main: Temp
}
