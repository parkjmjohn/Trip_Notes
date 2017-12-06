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

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: Spacing
    let padding1: CGFloat = 7
    let padding2: CGFloat = 40
    
    // MARK: UI
    var cancelButton: UIBarButtonItem!
    var searchBar: UISearchBar!
    var tableView: UITableView!
    
    // MARK: Cell
    var cities: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title
        title = "Search a Location"
        
        // Background Color
        view.backgroundColor = .white
        
        // UI setup
        setUpCancelButton()
        setUpSearchBar()
        setUpTableView()
    }
    
    // MARK: cancelButton setup
    func setUpCancelButton() {
        cancelButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(cancelButtonPressed))
        navigationItem.leftBarButtonItem = cancelButton
    }

    @objc func cancelButtonPressed() {
        cities.removeAll()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: searchBar setup
    func setUpSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: padding1, y: padding1, width: view.frame.width - padding1 * 2, height: padding2))
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
        tableView = UITableView(frame: CGRect(x: 0, y: padding1 * 2 + padding2, width: view.frame.width, height: view.frame.height - (padding1 * 5 + padding2 * 2)))
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
        navigationController?.pushViewController(cityViewController, animated: true)
    }
    
    // MARK: Required Swift function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//FIX - USE NETWORK MANAGER INSTEAD
    func getCities(input: String) {
        // GoogleAPI
        let googlePlacesAPI: String = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
        let space: String = "%20"
        let googleAPIkey: String = "&key=AIzaSyCympdqfdlfyrj-tJ8XzE5YFiWpaZCD8pU"
        
        let input: String = "input=" + input.replacingOccurrences(of: " ", with: space)
        let url: String = googlePlacesAPI + input + googleAPIkey
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
                            self.cities.append(City(label: ret))
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
