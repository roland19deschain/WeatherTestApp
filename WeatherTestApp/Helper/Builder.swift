//
//  Builder.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

final class Builder: BuilderProtocol {
    static func mainView(router: RouterProtocol) -> UIViewController {
        let main = MainProcessor(router: router)
        let mainController = MainController()
        mainController.main = main
        return mainController
    }
    
    static func tempView(response: WeatherResponse, router: RouterProtocol) -> UIViewController {
        let tempLoader = TempHandler(response: response, router: router)
        let tempController = TempController()
        tempController.tempHandler = tempLoader
        return tempController
    }
    
    static func mapView(mapData: MapData) -> UIViewController {
        let mapHandler = MapHandler(mapData: mapData)
        let map = MapController()
        map.mapHandler = mapHandler
        return map
    }
    
}
