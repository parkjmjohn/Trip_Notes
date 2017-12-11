//
//  SaveViewController.swift
//  TripNotes
//
//  Created by John Park on 12/6/17.
//  Copyright © 2017 John Park. All rights reserved.
//

import UIKit

protocol SaveProtocol {
    func saveCity(index: Int, city: City)
}

class SaveViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    var saveDelegate: SaveProtocol!
    var index: Int!
    
    // MARK: Init
    init(city: City) {
        super.init(nibName: nil, bundle: nil)
        self.city = city
    }
    
    init(city: City, index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.city = city
        self.index = index
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
        setUpNotes()
        setUpWeatherView()
        setUpTimeLabel()
        setUpPicture()
        setUpPriorityChooser()
        
        // title
        let str: String = label.text!
        if let range = str.range(of: ",") {
            title = String(str[..<range.lowerBound]).uppercased()
        } else {
            title = str.uppercased()
        }
    }
    
    // MARK: saveButton setup
    func setUpSaveButton() {
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveCity))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveCity() {
        city.notes = userNotes.text
        saveDelegate.saveCity(index: index, city: city)
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
        noteLabel = UILabel(frame: CGRect(x: padding2, y: (view.center.y + padding1 * 3.3) - fontSize, width: view.frame.width - padding2 * 2, height: fontSize))
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
        timeLabel.text = city.time
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
        picture.image = city.picture[0]
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
    
}
