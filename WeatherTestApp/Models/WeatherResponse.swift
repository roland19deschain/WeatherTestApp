//
//  WeatherResponse.swift
//  WeatherTestApp
//
//  Created by User on 8/14/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation

typealias Coordinates = (lat: Double, lon: Double)

struct WeatherResponse {
    let city: String
    let temp: String
    let description: String
    let coordinates: Coordinates
}
