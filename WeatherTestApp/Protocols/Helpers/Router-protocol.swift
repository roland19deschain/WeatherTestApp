//
//  Router-protocol.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

protocol RouterProtocol {
    init(navigationController: UINavigationController)
    func pushToTempController(response: WeatherResponse)
    func pushToMapController(mapData: MapData)
}
