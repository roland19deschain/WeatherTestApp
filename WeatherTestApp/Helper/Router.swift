//
//  Router.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

final class Router: RouterProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        initialController()
    }
    
    private func initialController() {
        navigationController.viewControllers = [Builder.mainView(router: self)]
    }
    
    func pushToTempController(response: WeatherResponse) {
        let temp = Builder.tempView(response: response, router: self)
        navigationController.pushViewController(temp, animated: true)
    }
    
    func pushToMapController(mapData: MapData) {
        let map = Builder.mapView(mapData: mapData)
        navigationController.pushViewController(map, animated: true)
    }
    
}
