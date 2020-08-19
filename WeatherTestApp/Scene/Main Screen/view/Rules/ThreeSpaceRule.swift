//
//  ThreeSpaceRule.swift
//  WeatherTestApp
//
//  Created by User on 8/19/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import SwiftValidator

final class ThreeSpaceRule: Rule {
    func validate(_ value: String) -> Bool { value != "   " }
    func errorMessage() -> String { "Invalidate name" }
}
