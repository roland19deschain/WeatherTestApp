//
//  MKAnnotations+Identifier.swift
//  WeatherTestApp
//
//  Created by User on 8/13/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import MapKit

extension MKAnnotation {
    static var identifier: String { String(describing: Self.self) }
}
