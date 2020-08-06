//
//  Main.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

final class MainProcessor: MainProcessorProtocol {
    private let router: RouterProtocol
    
    init(router: RouterProtocol) { self.router = router }
    
    func push(_ configure: (UINavigationItem) -> Void) {
        router.pushToTempController(configure)
    }
    
}
