//
//  CityViewController.swift
//  TripNotes
//
//  Created by John Park on 12/6/17.
//  Copyright © 2017 John Park. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

protocol CityProtocol {
    func didPressSaveCity(city: City)
}

class CityViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Spacing
    let padding1: CGFloat = 75
    let padding2: CGFloat = 8
    let padding3: CGFloat = 12
    let padding4: CGFloat = 150
    let fontSize: CGFloat = 20
    
    // MARK: UI
    var saveButton: UIBarButtonItem!
    var label: UILabel!
    var noteLabel: UILabel!
    var userNotes: UITextView!
    var timeLabel: UILabel!
    var weatherView: UICollectionView!
    var picture: UIImageView!
    var priorityLabel: UILabel!
    var priorityChooser: UIPickerView!
    
    // MARK: Data
    var city: City!
    let priorities = ["High", "Medium", "Low"]
    
    // MARK: Delegation
    var cityDelegate: CityProtocol!
    
    // MARK: Init
    init(city: City) {
        super.init(nibName: nil, bundle: nil)
        self.city = city
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background color
        view.backgroundColor = .white
        
        // UI setup
        setUpSaveButton()
        setUpLabels()
        setUpWeatherView()
        setUpNotes()
        setUpPriorityChooser()
        
        // title
        let str: String = label.text!
        if let range = str.range(of: ",") {
            title = String(str[..<range.lowerBound]).uppercased()
        } else {
            title = str.uppercased()
        }
        
        // Network
        setUpTimeLabel()
        getForecast(input: title!)
        setUpPicture()
        getPicture(input: title!)
    }
    
    // MARK: saveButton setup
    func setUpSaveButton() {
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveCity))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveCity() {
        city.notes = userNotes.text
        cityDelegate.didPressSaveCity(city: city)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: labels setup
    func setUpLabels() {
        label = UILabel(frame: CGRect(x: 0, y: padding1, width: view.frame.width, height: fontSize + 4))
        label.textAlignment = .center
        label.text = city.label
        label.font = UIFont(name: "Futura-CondensedExtraBold", size: fontSize)
        view.addSubview(label)
        
        priorityLabel = UILabel(frame: CGRect(x: padding3, y: padding1 * 1.9 + fontSize + padding3 + padding4 * 2, width: view.frame.width - padding3 * 2, height: fontSize + 4))
        updatePriorityLabel()
        priorityLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: fontSize)
        view.addSubview(priorityLabel)
    }
    
    func updatePriorityLabel() {
        priorityLabel.text = "Priority: " + city.priority
    }
    
    // MARK: noteLabel and userNotes setup
    func setUpNotes() {
        noteLabel = UILabel(frame: CGRect(x: padding2, y: (view.center.y + padding1 * 3.3) - fontSize, width: view.frame.width - padding2 * 2, height: fontSize + 2))
        noteLabel.text = "Notes:"
        view.addSubview(noteLabel)
        
        userNotes = UITextView(frame: CGRect(x: padding2, y: view.center.y + padding1 * 3.3, width: view.frame.width - padding2 * 2, height: padding1 * 1.5))
        userNotes.layer.cornerRadius = padding2
        userNotes.layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
        userNotes.layer.borderWidth = 1.0
        userNotes.font = UIFont(name: "AmericanTypewriter", size: 18.0)
        userNotes.textColor = .blue
        userNotes.text = city.notes
        view.addSubview(userNotes)
    }
    
    // MARK: timeLabel setup
    func setUpTimeLabel() {
        timeLabel = UILabel(frame: CGRect(x: padding3, y: padding1 + fontSize + padding3, width: view.frame.width - padding3 * 2, height: fontSize / 1.2 + 2))
        timeLabel.text = "Searching..."
        timeLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: fontSize / 1.5)
        view.addSubview(timeLabel)
    }
    
    // MARK: weatherView setup
    func setUpWeatherView() {
        weatherView = UICollectionView(frame: CGRect(x: 0, y: padding1 * 1.5 + fontSize + padding3, width: view.frame.width, height: padding4), collectionViewLayout: UICollectionViewFlowLayout())
        weatherView.backgroundColor = .white
        weatherView.register(WeatherViewCell.self, forCellWithReuseIdentifier: "WeatherViewCell")
        weatherView.delegate = self
        weatherView.dataSource = self
        
        // setting horizontal scroll view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.weatherView.collectionViewLayout = layout
        weatherView.showsHorizontalScrollIndicator = false
        view.addSubview(weatherView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return city.weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weatherView.dequeueReusableCell(withReuseIdentifier: "WeatherViewCell", for: indexPath) as! WeatherViewCell
        cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        cell.setUpWeather(weather: city.weather[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: padding4, height: padding4)
    }
    
    // MARK: Picture setup
    func setUpPicture() {
        picture = UIImageView(frame: CGRect(x: 0, y: padding1 * 1.75 + fontSize + padding3 + padding4, width: view.frame.width, height: padding4))
        picture.contentMode = .scaleAspectFit
        view.addSubview(picture)
    }
    
    // MARK: Priority setup
    func setUpPriorityChooser() {
        priorityChooser = UIPickerView(frame: CGRect(x: 0, y: padding1 * 1.9 + fontSize + padding3 + padding4 * 2, width: view.frame.width, height: padding4))
        priorityChooser.dataSource = self
        priorityChooser.delegate = self
        view.addSubview(priorityChooser)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        city.priority = priorities[row]
        updatePriorityLabel()
    }
    
    // MARK: Required Swift function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//FIX - USE NETWORK MANAGER INSTEAD
    func getForecast(input: String) {
        let apixiAPI = "https://api.apixu.com/v1/forecast.json?"
        let space = "%20"
        let apixiKey = "key=04bbf229c12940a49e8173840170812"
        let input = "&q=" + input.replacingOccurrences(of: " ", with: space)
        let url = apixiAPI + apixiKey + input
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case let .success(data):
                    let json = JSON(data)
                    if let time = json["location"]["localtime"].string {
                        self.city.time = "Time: " + time
                        var counter: Int = 0
                        while counter < 24 {
                            let hour: String = (json["forecast"]["forecastday"][0]["hour"].array?[counter]["time"].string)!
                            let hourTemp: Int = (json["forecast"]["forecastday"][0]["hour"].array?[counter]["temp_f"].int)!
                            let hourRain: String = (json["forecast"]["forecastday"][0]["hour"].array?[counter]["chance_of_rain"].string)!
                            let hourText: String = (json["forecast"]["forecastday"][0]["hour"].array?[counter]["condition"]["text"].string)!
                            let hourImg: String =  (json["forecast"]["forecastday"][0]["hour"].array?[counter]["condition"]["icon"].string)!
                            self.city.weather.append(Weather(hour: hour, hourTemp: hourTemp, hourRain: hourRain, hourText: hourText, hourImg: hourImg))
                            counter += 1
                        }
                        self.weatherView.reloadData()
                    } else {
                        self.city.time = "Time: N/A"
                    }
                    self.timeLabel.text = self.city.time
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
//FIX - USE NETWORK MANAGER INSTEAD
    func getPicture(input: String) {
        let url = "https://source.unsplash.com/1600x900/?" + input
        Alamofire.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.city.picture.append(image)
                    self.picture.image = self.city.picture[0]
                } else {
                    self.city.picture.append(#imageLiteral(resourceName: "picture"))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
