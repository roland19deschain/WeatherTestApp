//
//  Main.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit
import RxSwift

final class MainProcessor: MainProcessorProtocol {
    private let router: RouterProtocol
    
    init(router: RouterProtocol) { self.router = router }
    
    func loadTemp(city: String, errorHandle: @escaping (Error) -> Void) {
        APIService
            .shared
            .rxResponse(by: Constants.urlString,
                        parameters: ["q": city, "APPID": Constants.apiKey]) { (response: Observable<Weather>?, error) in
                if let error = error {
                    errorHandle(error)
                    return
                }
                var weatherResponse: WeatherResponse!
                _ = response?
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { response in
                        let temp = "\(Int(response.main.temp - Constants.kelvin))"
                        let description = response.weather.first?.main ?? ""
                        let coordinates = response.coord
                        weatherResponse = .init(city: city, temp: temp, description: description, coordinates: (coordinates.lat, coordinates.lon))
                    }, onCompleted: {
                        self.push(response: weatherResponse)
                    })
        }
    }
    
    private func push(response: WeatherResponse) {
        router.pushToTempController(response: response)
    }
    
}
