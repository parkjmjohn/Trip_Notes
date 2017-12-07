//
//  ViewController.swift
//  TripNotes
//
//  Created by John Park on 11/29/17.
//  Copyright © 2017 John Park. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchProtocol {
    
    // MARK: UI
    var tableView: UITableView!
    var createNote: UIBarButtonItem!
    
    // MARKL: Cell
    var cities: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title
        title = "Trip Notes"
        
        // UI setup
        setUpTableView()
        setUpCreateNote()
    }
    
    // MARK: tableView setup
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: createNote setup
    func setUpCreateNote() {
        createNote = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNotePressed))
        navigationItem.rightBarButtonItem = createNote
    }
    
    @objc func createNotePressed() {
//        let searchViewController = UINavigationController(rootViewController: SearchViewController()
//        searchViewController.navigationBar.barTintColor = .white
//        searchViewController.navigationBar.isTranslucent = false
//        present(searchViewController, animated: true)
        let searchViewController = SearchViewController()
        searchViewController.citiesDelegate = self
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    // MARK: Delegations
    func didPressDone(cities: [City]) {
        for City in cities {
            self.cities.append(City)
        }
        tableView.reloadData()
    }
    
    // MARK: Required Swift function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
