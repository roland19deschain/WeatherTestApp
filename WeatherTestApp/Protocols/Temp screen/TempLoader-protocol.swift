//
//  TempLoader-protocol.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation

typealias WeatherResponse = (temp: String, description: String)

protocol TempLoaderProtocol {
    init(router: RouterProtocol)
    func loadTemp(city: String, successHandle: @escaping (WeatherResponse) -> Void, errorHandle: @escaping (Error) -> Void)
    func pushToMap(type: Map)
}
