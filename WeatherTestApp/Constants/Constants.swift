//
//  Constants.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation

struct Constants {
    private static let apiKey = "439d4b804bc8187953eb36d2a8c26a02"
    static func urlString(with city: String) -> String { "https://samples.openweathermap.org/data/2.5/weather?q=\(city)&appid=" + apiKey }
    
    static let kelvin = 273.5
}
