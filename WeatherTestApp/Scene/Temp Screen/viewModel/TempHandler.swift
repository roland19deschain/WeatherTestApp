//
//  TempHandler.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import RxSwift

final class TempHandler: TempHandlerProtocol {
    private let response: WeatherResponse!
    private let router: RouterProtocol
    var title: String { response.city }
    var temp: String { response.temp }
    var description: String { response.description }
    var lat: Double { response.coordinates.lat }
    var lon: Double { response.coordinates.lon }
    
    init(response: WeatherResponse, router: RouterProtocol) {
        self.response = response
        self.router = router
    }

    func pushToMap(mapData: MapData) {
        router.pushToMapController(mapData: mapData)
    }
    
}
