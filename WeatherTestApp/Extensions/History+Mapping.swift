//
//  History+Mapping.swift
//  WeatherTestApp
//
//  Created by User on 8/31/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation

extension History: ManagedObjectProtocol {
    func toMappedObject<T>() -> T? where T : MappedObjectProtocol {
        CDHistory(date: date!,
                  city: city ?? "",
                  temp: temp ?? "",
                  weather: weather ?? "",
                  identifier: objectID.uriRepresentation().absoluteString) as? T
    }
}
