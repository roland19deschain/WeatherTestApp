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
        let main = Main(router: router)
        let mainController = MainController()
        mainController.main = main
        return mainController
    }
    
    static func tempView() -> UIViewController {
        let tempLoader = TempLoader()
        let tempController = TempController()
        tempController.tempLoader = tempLoader
        return tempController
    }
    
}
