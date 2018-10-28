//
//  Circle.swift
//  day06
//
//  Created by Ivan Zelenskyi on 10/9/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import Foundation
import CoreGraphics

class Circle{
    var coord : Coord
    var color : CGColor
    var radius : Double
    
    init(center : Coord, color : CGColor, radius : Double) {
        self.color = color
        self.radius = radius
        self.color = color
    }
}
