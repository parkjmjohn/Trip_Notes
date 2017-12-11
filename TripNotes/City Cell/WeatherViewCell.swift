//
//  WeatherViewCell.swift
//  TripNotes
//
//  Created by John Park on 12/10/17.
//  Copyright © 2017 John Park. All rights reserved.
//

import UIKit

class WeatherViewCell: UICollectionViewCell {
    
    // MARK: spacing
    var padding1: CGFloat = 6
    var fontSize1: CGFloat = 16
    var fontSize2: CGFloat = 13
    var imgSize: CGFloat = 35
    
    // MARK: parameters
    var weather: Weather!
    var hourLabel: UILabel!
    var hourTempLabel: UILabel!
    var hourRainLabel: UILabel!
    var hourImg: UIImageView!
    var hourText: UILabel!
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //UI add
        setUpLabels()
        setUpHourImg()
    }
    
    func setUpWeather(weather: Weather) {
        self.weather = weather
        hourLabel.text = weather.hour
        hourTempLabel.text = "Temperature (°F):     " + String(weather.hourTemp)
        hourRainLabel.text = "Chance of rain:     " + weather.hourRain + "%"
        hourText.text = weather.hourText
        
        //setup UIImage string
        print(weather.hourImg)
        let data = try? Data(contentsOf: URL(string: "http:" + weather.hourImg)!)
        hourImg.image = UIImage(data: data!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Labels setup
    func setUpLabels() {
        // hourLabel
        hourLabel = UILabel(frame: CGRect(x: 0, y: padding1, width: frame.width, height: fontSize1 + 4))
        hourLabel.textAlignment = .center
        hourLabel.font = UIFont(name: "TimesNewRomanPSMT", size: fontSize1)
        contentView.addSubview(hourLabel)
        
        // hourTempLabel
        hourTempLabel = UILabel(frame: CGRect(x: padding1, y: padding1 * 2 + fontSize1 + 4, width: frame.width - padding1, height: fontSize2 + 3))
        hourTempLabel.font = UIFont(name: "TimesNewRomanPSMT", size: fontSize2)
        contentView.addSubview(hourTempLabel)
        
        // hourRainLabel
        hourRainLabel = UILabel(frame: CGRect(x: padding1, y: padding1 * 3 + fontSize1 + 4 + fontSize2 + 3, width: frame.width - padding1, height: fontSize2 + 3))
        hourRainLabel.font = UIFont(name: "TimesNewRomanPSMT", size: fontSize2)
        contentView.addSubview(hourRainLabel)
        
        // hourText
        hourText = UILabel(frame: CGRect(x: 0, y: padding1 * 5 + fontSize1 + 4 + (fontSize2 + 3) * 2 + imgSize, width: frame.width, height: fontSize2 + 3))
        hourText.font = UIFont(name: "TimesNewRomanPSMT", size: fontSize2)
        hourText.textAlignment = .center
        contentView.addSubview(hourText)
    }
    
    // MARK: hourImg setup
    func setUpHourImg() {
        hourImg = UIImageView(frame: CGRect(x: 0, y: padding1 * 4 + fontSize1 + 4 + (fontSize2 + 3) * 2, width: imgSize, height: imgSize))
        hourImg.center.x = center.x
        contentView.addSubview(hourImg)
    }
    
}
