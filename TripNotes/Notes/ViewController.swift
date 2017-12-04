//
//  ViewController.swift
//  TripNotes
//
//  Created by John Park on 11/29/17.
//  Copyright © 2017 John Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UI
    var createNote: UIBarButtonItem!
    var tableView: UITableView!
    
    // MARK: Cell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title
        title = "Trip Notes"
        
        // Setup UI
        setUpCreateNote()
        setUpTableView()
    }

    // MARK: Note button setup
    func setUpCreateNote() {
        createNote = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNotePressed))
        navigationItem.rightBarButtonItem = createNote
    }
    
    // MARK: Action Targets
    @objc func createNotePressed() {
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        searchViewController.navigationBar.barTintColor = .white
        searchViewController.navigationBar.isTranslucent = false
        present(searchViewController, animated: true)
    }
    
    // MARK: TableView setup
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
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
        return cell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

