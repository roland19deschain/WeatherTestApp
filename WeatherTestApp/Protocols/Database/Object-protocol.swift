//
//  Object-protocol.swift
//  WeatherTestApp
//
//  Created by User on 8/31/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import CoreData

protocol ObjectProtocol: NSManagedObject {
    func toMappedObject<T: MappedObjectProtocol>() -> T?
}
