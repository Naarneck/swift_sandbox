//
//  MapPin.swift
//  day05
//
//  Created by Ivan Zelenskyi on 10/8/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import Foundation
import MapKit

class MapPin : NSObject, MKAnnotation {
    var title : String?
    var subtitle : String?
    var coordinate : CLLocationCoordinate2D
    var pinTintColor : UIColor
    
    init(title : String, subtitle: String, coordinate : CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.pinTintColor = .red
    }
    
}
