//
//  MKAnnotations+MapItem.swift
//  WeatherTestApp
//
//  Created by User on 8/13/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import MapKit

extension MKAnnotation {
    var mapItem: MKMapItem {
        let placemark = MKPlacemark(coordinate: coordinate)
        let item = MKMapItem(placemark: placemark)
        item.name = title ?? ""
        return item
    }
}
