//
//  MyNavigationController.swift
//  WeatherTestApp
//
//  Created by User on 8/17/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

final class MyNavigationController: UINavigationController {
    override func popViewController(animated: Bool) -> UIViewController? {
        if visibleViewController is TempController { self.isNavigationBarHidden = true  }
        return super.popViewController(animated: animated)
    }
}
