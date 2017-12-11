//
//  SearchViewController.swift
//  TripNotes
//
//  Created by John Park on 11/29/17.
//  Copyright © 2017 John Park. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

protocol SearchProtocol {
    func didPressDone(cities: [City])
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CityProtocol {
    
    // MARK: Spacing
    let padding1: CGFloat = 50
    let padding2: CGFloat = 90
    
    // MARK: UI
    var doneButton: UIBarButtonItem!
    var searchBar: UISearchBar!
    var tableView: UITableView!
    
    // MARK: Data
    var cities: [City] = []
    var saveCities: [City] = []
    
    // MARK: Delegations
    var citiesDelegate: SearchProtocol!
    
    func didPressSaveCity(city: City) {
        saveCities.append(city)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title
        title = "Search a Location"
        
        // Background Color
        view.backgroundColor = .white
        
        // UI setup
        setUpDoneButton()
        setUpSearchBar()
        setUpTableView()
    }
    
    // MARK: cancelButton setup
    func setUpDoneButton() {
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.leftBarButtonItem = doneButton
    }

    @objc func doneButtonPressed() {
        citiesDelegate.didPressDone(cities: saveCities)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: searchBar setup
    func setUpSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: padding1, width: view.frame.width, height: padding2))
        searchBar.placeholder = "Search a Location..."
        searchBar.barTintColor = .white
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        if searchBar.text != "" {
            title = "Results for: " + searchBar.text!
            getCities(input: searchBar.text!)
        } else {
            title = "Search a Location"
            cities.removeAll()
            tableView.reloadData()
        }
    }
    
    // MARK: tableView setup
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: padding1 + padding2, width: view.frame.width, height: view.frame.height - (padding1 + padding2)))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteCell.self, forCellReuseIdentifier: "NoteCell")
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.setUpLabelTitle(city: cities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityViewController = CityViewController(city: cities[indexPath.row])
        cityViewController.cityDelegate = self
        navigationController?.pushViewController(cityViewController, animated: true)
    }
    
    // MARK: Required Swift function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//FIX - USE NETWORK MANAGER INSTEAD
    func getCities(input: String) {
        // GoogleAPI
        let googlePlacesAPI = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
        let space = "%20"
        let googleAPIkey = "&key=AIzaSyCympdqfdlfyrj-tJ8XzE5YFiWpaZCD8pU"
        let input = "input=" + input.replacingOccurrences(of: " ", with: space)
        let url = googlePlacesAPI + input + googleAPIkey
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case let .success(data):
                    let json = JSON(data)
                    if json["predictions"].array?.first?["description"].string != nil {
                        self.cities.removeAll()
                        var counter: Int = 0
                        while counter != json["predictions"].array?.count {
                            let ret: String = (json["predictions"].array?[counter]["description"].string)!
                            self.cities.append(City(label: ret, notes: "", time: "", weather: [], picture: [], priority: ""))
                            counter += 1
                        }
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
}
