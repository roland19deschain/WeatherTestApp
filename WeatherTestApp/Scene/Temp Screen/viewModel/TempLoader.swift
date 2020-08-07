//
//  TempLoader.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import RxSwift

final class TempLoader: TempLoaderProtocol {
    private let router: RouterProtocol
    
    init(router: RouterProtocol) { self.router = router }
    
    func loadTemp(city: String, successHandle: @escaping (WeatherResponse) -> Void, errorHandle: @escaping (Error) -> Void) {
        APIService
            .shared
            .rxResponse(by: Constants.urlString,
                        parameters: ["q": city, "APPID": Constants.apiKey]) { (response: Observable<Weather>?, error) in
                if let error = error {
                    errorHandle(error)
                    return
                }
                
                _ = response?
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { response in
                        let temp = "\(Int(response.main.temp - Constants.kelvin))"
                        let description = response.weather.first?.main ?? ""
                        successHandle((temp, description))
                    })
        }
    }
    
    func pushToMap(type: Map) {
        router.pushToMapController(type: type)
    }
    
}
