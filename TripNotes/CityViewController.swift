//
//  CityViewController.swift
//  TripNotes
//
//  Created by John Park on 12/6/17.
//  Copyright © 2017 John Park. All rights reserved.
//

import UIKit

protocol CityProtocol {
    func didPressSaveCity(city: City)
}

class CityViewController: UIViewController {

    // MARK: Spacing
    let padding1: CGFloat = 75
    let fontSize: CGFloat = 20
    
    // MARK: UI
    var saveButton: UIBarButtonItem!
    var label: UILabel!
    
    // MARK: Data
    var city: City!
    
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
        setUpLabel()
        
        // title
        let str: String = label.text!
        if let range = str.range(of: ",") {
            let ret = str[..<range.lowerBound]
            title = String(ret).uppercased()
        }
    }
    
    // MARK: saveButton setup
    func setUpSaveButton() {
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveCity))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveCity() {
        cityDelegate.didPressSaveCity(city: city)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: label setup
    func setUpLabel() {
        label = UILabel(frame: CGRect(x: 0, y: padding1, width: view.frame.width, height: fontSize))
        label.textAlignment = .center
        label.text = city.label
        label.font = UIFont(name: "Futura-CondensedExtraBold", size: fontSize)
        view.addSubview(label)
    }

    // MARK: Required Swift function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
