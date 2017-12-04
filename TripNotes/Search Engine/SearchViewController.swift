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

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Spacing
    var padding1: CGFloat = 30
    var padding2: CGFloat = 7
    var padding3: CGFloat = 3
    
    // MARK: UI
    var cancelButton: UIBarButtonItem!
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var searchButton: UIButton!
    
    // MARK: Cell
    var cities: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title
        title = "Search a City"
        
        // Background Color
        view.backgroundColor = .white
        
        // Setup UI
        setUpCancelbutton()
        setUpTableView()
        setUpSearchBar()
        setUpSearchButton()
    }

    // MARK: Cancel Button setup
    func setUpCancelbutton() {
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: TableView setup
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: padding1 + padding2 * 3, width: view.frame.width, height: view.frame.height - padding1 - padding2 * 3))
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.setupCell(city: cities[indexPath.row])
        return cell
    }
    
    // MARK: Searchbar setup
    func setUpSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: padding2 * 2.5, y: padding2 * 2, width: view.frame.width - padding1 * 3, height: padding1))
        searchBar.placeholder = "Search a city..."
        view.addSubview(searchBar)
    }
    
    // MARK: Searchbutton setup
    func setUpSearchButton() {
        searchButton = UIButton(frame: CGRect(x: 1.5 * (padding2 * 2.5) + (view.frame.width - padding1 * 3) - padding3, y: searchBar.center.y - (padding2 * 2) - padding3, width: 0, height: 0))
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.blue, for: .normal)
        searchButton.sizeToFit()
        searchButton.addTarget(self, action: #selector(didPressSearchButton), for: .touchUpInside)
        view.addSubview(searchButton)
    }
    
    // MARK: Action Listener
    @objc func didPressSearchButton() {
//        cities = NetworkManager.getCities(parameter: searchBar.text)
        let googlePlacesAPI: String = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
        let space: String = "%20"
        let googleAPIkey: String = "&key=AIzaSyCympdqfdlfyrj-tJ8XzE5YFiWpaZCD8pU"
        let input: String = "input=" + searchBar.text!.replacingOccurrences(of: " ", with: space)
        let url: String = googlePlacesAPI + input + googleAPIkey
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case let .success(data):
                    let json = JSON(data)
                    if json["predictions"].array?.first?["description"].string != nil {
                        print ("success")
                        var counter: Int = 0
                        while counter != json["predictions"].array?.count {
                            let description: String = (json["predictions"].array?[counter]["description"].string)!
                            print(description)
                            self.cities.append(City(description: description))
                            counter += 1
                        }
                    } else { print("failure")}
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
