//
//  Route.swift
//  WeatherTestApp
//
//  Created by User on 8/17/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation

struct Route: Codable {
    let overviewPolyline: OverviewPolyline

    enum CodingKeys: String, CodingKey { case overviewPolyline = "overview_polyline" }
}
