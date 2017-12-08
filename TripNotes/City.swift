//
//  City.swift
//  TripNotes
//
//  Created by John Park on 11/30/17.
//  Copyright © 2017 John Park. All rights reserved.
//
import Foundation

struct City {
    
    // MARK: title
    var label: String
    var notes: String
    
    // MARK: init
    init(label: String, notes: String) {
        self.label = label
        self.notes = notes
    }
    
}

