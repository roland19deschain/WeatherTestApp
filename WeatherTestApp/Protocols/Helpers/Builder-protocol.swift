//
//  Builder-protocol.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

protocol BuilderProtocol {
    static func mainView(router: RouterProtocol) -> UIViewController
    static func tempView() -> UIViewController
}