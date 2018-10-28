//
//  Item.swift
//  day02
//
//  Created by Ivan Zelenskyi on 10/3/18.
//  Copyright © 2018 Ivan Zelenskyi. All rights reserved.
//

import Foundation

class Item{
    var date: Date
    var name: String
    var desc: String
    
    init(date: Date, name: String, desc: String){
        self.date = date
        self.name = name
        self.desc = desc
    }
}
 
