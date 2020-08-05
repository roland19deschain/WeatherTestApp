//
//  Alert.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

struct Alert {
    private static func alert(_ controller: UIViewController,
                              title: String?,
                              message: String?,
                              _ configure: ((UIAlertController) -> Void)? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Translate.cancel, style: .cancel, handler: nil))
        configure?(alert)
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func error(_ controller: UIViewController, message: String?) {
        alert(controller, title: Translate.error, message: message)
    }
}
