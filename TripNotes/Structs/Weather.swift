//
//  Weather.swift
//  TripNotes
//
//  Created by John Park on 12/9/17.
//  Copyright © 2017 John Park. All rights reserved.
//

import UIKit

struct Weather {
    var hour: Int
    var hourTemp: String
    var hourRain: String
    var hourText: String
    var hourImg: UIImage
    
    init(hour: Int, hourTemp: String, hourRain: String, hourText: String, hourImg: UIImage) {
        self.hour = hour
        self.hourTemp = hourTemp
        self.hourRain = hourRain
        self.hourText = hourText
        self.hourImg = hourImg
    }
    
}
