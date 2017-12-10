//
//  Weather.swift
//  TripNotes
//
//  Created by John Park on 12/9/17.
//  Copyright © 2017 John Park. All rights reserved.
//

import Foundation

struct Weather {
    var hour: String
    var hourTemp: Int
    var hourRain: String
    var hourText: String
    var hourImg: String
    
    init(hour: String, hourTemp: Int, hourRain: String, hourText: String, hourImg: String) {
        self.hour = hour
        self.hourTemp = hourTemp
        self.hourRain = hourRain
        self.hourText = hourText
        self.hourImg = hourImg
    }
    
}
