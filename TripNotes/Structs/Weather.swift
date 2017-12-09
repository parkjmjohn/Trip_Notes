//
//  Weather.swift
//  TripNotes
//
//  Created by John Park on 12/9/17.
//  Copyright © 2017 John Park. All rights reserved.
//

import UIKit

struct Weather {
    var time: String
    var hour: String
    var hourTemp: String
    var hourRain: String
    var hourText: String
    var hourImg: UIImage
    
    init(time: String, hour: String, hourTemp: String, hourRain: String, hourText: String, hourImg: UIImage) {
        self.time = time
        self.hour = hour
        self.hourTemp = hourTemp
        self.hourRain = hourRain
        self.hourText = hourText
        self.hourImg = hourImg
    }
    
}
