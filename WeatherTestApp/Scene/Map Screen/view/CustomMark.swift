//
//  CustomMark.swift
//  WeatherTestApp
//
//  Created by User on 8/13/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import MapKit

final class CustomMark: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
