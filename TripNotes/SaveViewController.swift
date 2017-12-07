//
//  SaveViewController.swift
//  TripNotes
//
//  Created by John Park on 12/6/17.
//  Copyright © 2017 John Park. All rights reserved.
//

import UIKit

protocol SaveProtocol {
    func saveCity(index: Int, notes: String)
}

class SaveViewController: UIViewController {
    
    // MARK: Spacing
    let padding1: CGFloat = 75
    let padding2: CGFloat = 8
    let fontSize: CGFloat = 20
    
    // MARK: UI
    var saveButton: UIBarButtonItem!
    var label: UILabel!
    var noteLabel: UILabel!
    var userNotes: UITextField!
    
    // MARK: Data
    var city: City!
    
    // MARK: Delegation
    var saveDelegate: SaveProtocol!
    var cityNotes: String!
    var index: Int!
    
    // MARK: Init
    init(city: City) {
        super.init(nibName: nil, bundle: nil)
        self.city = city
    }
    
    init(city: City, notes: String, index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.city = city
        cityNotes = notes
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
        setUpLabel()
        setUpNotes()
        
        // title
        let str: String = label.text!
        if let range = str.range(of: ",") {
            let ret = str[..<range.lowerBound]
            title = String(ret).uppercased()
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
        saveDelegate.saveCity(index: index, notes: cityNotes)
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
    
    // MARK: noteLabel and userNotes setup
    func setUpNotes() {
        
        noteLabel = UILabel(frame: CGRect(x: padding2, y: (view.center.y + padding1 * 3.3) - fontSize, width: view.frame.width - padding2 * 2, height: fontSize))
        noteLabel.text = "Notes:"
        view.addSubview(noteLabel)
        
        userNotes = UITextField(frame: CGRect(x: padding2, y: view.center.y + padding1 * 3.3, width: view.frame.width - padding2 * 2, height: padding1 * 1.5))
        userNotes.borderStyle = .roundedRect
        userNotes.tintColor = .black
        userNotes.text = cityNotes
        view.addSubview(userNotes)
    }
    
    // MARK: Required Swift function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
