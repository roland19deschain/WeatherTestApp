//
//  MainProcessor-protocol.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

protocol MainProcessorProtocol {
    init(router: RouterProtocol)
    func loadTemp(city: String, errorHandle: @escaping (APIService.NetworkError) -> Void) 
}
