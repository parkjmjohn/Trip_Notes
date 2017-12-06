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

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Spacing
    var padding1: CGFloat = 7
    var padding2: CGFloat = 40
    
    // MARK: UI
    var cancelButton: UIBarButtonItem!
    var searchBar: UISearchBar!
    var tableView: UITableView!
    
    // MARK: Cell
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title
        title = "Search a City"
        
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
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: searchBar setup
    func setUpSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: padding1, y: padding1, width: view.frame.width - padding1 * 2, height: padding2))
        searchBar.placeholder = "Search a city..."
        searchBar.barTintColor = .white
        view.addSubview(searchBar)
    }
    
    // MARK: tableView setup
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: padding1 * 2 + padding2, width: view.frame.width, height: view.frame.height - padding1 * 2 - padding2))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteCell.self, forCellReuseIdentifier: "NoteCell")
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
//DEBUG cell.setUpLabelTitle(title: "Test")
        return cell
    }
    
    // MARK: Required Swift function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
