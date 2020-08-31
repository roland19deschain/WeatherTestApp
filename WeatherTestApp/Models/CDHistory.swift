//
//  CDHistory.swift
//  WeatherTestApp
//
//  Created by User on 8/31/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import CoreData

struct CDHistory: MappedObjectProtocol {
    var date: Date
    var city: String
    var temp: String
    var weather: String
    var identifier: String
    
    func toObject(context: NSManagedObjectContext?) -> History {
        let history = History(context: context!)
        history.date = date
        history.city = city
        history.temp = temp
        history.weather = weather
        return history
    }

}
