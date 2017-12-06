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
    var padding1: CGFloat = 7
    var padding2: CGFloat = 40
    
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
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
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
//DEBUG        cities.append(City(label: "Testing"))
        if searchBar.text != "" {
            title = "Results for: " + searchBar.text!
        } else {
            title = "Search a Location"
        }
//        cities = NetworkManager.getCities(input: searchBar.text!)
//DEBUG        print(cities)
        
//DEBUG USE NETWORKMANAGER instead
//        cities.removeAll()
        getCities(input: searchBar.text!)
        tableView.reloadData()
        cities.removeAll()
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
    
    // MARK: Required Swift function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// DEBUG - USE NETWORK MANAGER INSTEAD
    func getCities(input: String) {
        //DEBUG        print("attempted1")
        // GoogleAPI
        let googlePlacesAPI: String = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
        let space: String = "%20"
        let googleAPIkey: String = "&key=AIzaSyCympdqfdlfyrj-tJ8XzE5YFiWpaZCD8pU"
        
//        var cities: [City] = []
        let input: String = "input=" + input.replacingOccurrences(of: " ", with: space)
        let url: String = googlePlacesAPI + input + googleAPIkey
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case let .success(data):
                    let json = JSON(data)
                    //DEBUG                    print("attempted2")
                    if json["predictions"].array?.first?["description"].string != nil {
                        var counter: Int = 0
                        while counter != json["predictions"].array?.count {
                            let ret: String = (json["predictions"].array?[counter]["description"].string)!
//DEBUG                            print(ret)
                            self.cities.append(City(label: ret))
                            counter += 1
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
}
