//
//  City.swift
//  TripNotes
//
//  Created by John Park on 11/30/17.
//  Copyright © 2017 John Park. All rights reserved.
//
import UIKit

struct City {
    
    // MARK: title
    var label: String
    var notes: String
    var time: String
    var weather: [Weather]
    var picture: [UIImage]
    var priority: String
    
    // MARK: init
    init(label: String, notes: String, time: String, weather: [Weather], picture: [UIImage], priority: String) {
        self.label = label
        self.notes = notes
        self.time = time
        self.weather = weather
        self.picture = picture
        self.priority = priority
    }
    
}

