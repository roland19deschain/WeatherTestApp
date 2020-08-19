//
//  LineCountRule.swift
//  WeatherTestApp
//
//  Created by User on 8/19/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import SwiftValidator

final class LineCountRule: Rule {
    func validate(_ value: String) -> Bool { value.count >= 2 }
    func errorMessage() -> String { "Line count must be bigger or equal 2 character" }
}
