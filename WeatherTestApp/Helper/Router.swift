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
    
    func pushToTempController(_ configure: (UINavigationItem) -> Void) {
        let temp = Builder.tempView(router: self)
        configure(temp.navigationItem)
        navigationController.pushViewController(temp, animated: true)
    }
    
    func pushToMapController(type: Map) {
        let map = Builder.mapView(type: type)
        navigationController.pushViewController(map, animated: true)
    }
    
}
