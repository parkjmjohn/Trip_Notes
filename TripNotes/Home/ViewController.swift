//
//  ViewController.swift
//  TripNotes
//
//  Created by John Park on 11/29/17.
//  Copyright © 2017 John Park. All rights reserved.
//
import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchProtocol, SaveProtocol {
    
    // MARK: UI
    var tableView: UITableView!
    var createNote: UIBarButtonItem!
    
    // MARKL: Cell
    var saveCities: [City] = []
    
    // Firebase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title
        title = "Trip Notes"
        
        // UI setup
        setUpTableView()
        setUpCreateNote()
        
//        // FirebaseReference
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
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
        return saveCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.setUpLabelTitle(city: saveCities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            saveCities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let saveViewController = SaveViewController(city: saveCities[indexPath.row], index: indexPath.row)
        saveViewController.saveDelegate = self
        navigationController?.pushViewController(saveViewController, animated: true)
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
            self.saveCities.append(City)
        }
        tableView.reloadData()
    }
    
    func saveCity(index: Int, city: City) {
        saveCities[index] = city
    }
    
    // MARK: Required Swift function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
