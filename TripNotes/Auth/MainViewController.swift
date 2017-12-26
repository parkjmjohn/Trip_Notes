//
//  MainViewController.swift
//  TripNotes
//
//  Created by John Park on 12/25/17.
//  Copyright © 2017 John Park. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController, UITextFieldDelegate {

    // MARK: Spacing
    let padding0: CGFloat = 120.0
    let padding1: CGFloat = 220.0
    let textSize0: CGFloat = 18.0
    let const: CGFloat = 1.8
    
    // MARK: SegmentedController
    let options = ["Login", "Sign Up"]
    
    // MARK: UI
    var descriptor: UILabel!
    var email: UITextField!
    var password: UITextField!
    var selector: UISegmentedControl!
    var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title
        title = "Login"
        
        // Background color
        view.backgroundColor = .white
        
        // UI
        setUpDescriptor()
        setUpTextFields()
        setUpSelector()
        setUpButton()
    }
    
    // MARK: setUpDescriptor()
    func setUpDescriptor() {
        descriptor = UILabel(frame: CGRect(x: 0.0, y: 80, width: view.frame.width, height: textSize0 * const))
        descriptor.font = UIFont(name: "Farah", size: textSize0)
        descriptor.text = "Welcome to Trip Notes"
        descriptor.textAlignment = .center
        view.addSubview(descriptor)
    }
    
    func updateDescriptor(newText: String) {
        descriptor.text = newText
    }

    // MARK: setUpButton()
    func setUpButton() {
        goButton = UIButton(frame: CGRect(x: 0.0, y: padding0 * 1.5 + textSize0 * const * 3.0, width: padding1, height: textSize0 * const))
        goButton.center.x = view.center.x
        goButton.layer.cornerRadius = 10.0
        goButton.layer.borderWidth = 1.0
        goButton.layer.borderColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.0).cgColor
        goButton.backgroundColor = UIColor(red: 0.32, green: 0.91, blue: 0.13, alpha: 1.0)
        changeButtonTitle()
        goButton.addTarget(self, action: #selector(goProcess), for: .touchUpInside)
        view.addSubview(goButton)
    }
    
    @objc func goProcess() {
        let userEmail = email.text
        let userPassword = password.text
        if userEmail != "" && userPassword != "" {
            if selector.selectedSegmentIndex == 0 {
                Auth.auth().signIn(withEmail: userEmail!, password: userPassword!, completion: { (user, error) in
                    if user != nil {
                        let viewController = ViewController()
                        self.navigationController?.pushViewController(viewController, animated: true)
                    } else {
                        if let userError = error?.localizedDescription {
                            self.updateDescriptor(newText: userError)
                            print(userError)
                        } else {
                            print("unexpected error")
                        }
                    }
                })
            } else {
                Auth.auth().createUser(withEmail: userEmail!, password: userPassword!, completion: { (user, error) in
                    if user != nil {
                        self.email.text = ""
                        self.password.text = ""
                        self.selector.selectedSegmentIndex = 0
                        self.updateDescriptor(newText: "Sign Up Success")
                        self.changeOptions()
                    } else {
                        if let userError = error?.localizedDescription {
                            self.updateDescriptor(newText: userError)
                            print(userError)
                        } else {
                            print("unexpected error")
                        }
                    }
                })
            }
        } else {
            updateDescriptor(newText: "Fill in fields")
        }
    }
    
    // MARK: login & signup setup
    func setUpTextFields() {
        email = UITextField(frame: CGRect(x: 0, y: padding0 * 1.1 + textSize0 * const * 1.0, width: padding1, height: textSize0 * const))
        email.center.x = view.center.x
        email.layer.cornerRadius = 10.0
        email.borderStyle = .bezel
        email.placeholder = " e-mail"
        email.autocorrectionType = .no
        email.autocapitalizationType = .none
        email.spellCheckingType = .no
        email.font = UIFont(name: "Farah", size: textSize0)
        email.delegate = self
        view.addSubview(email)
        
        password = UITextField(frame: CGRect(x: 0, y: padding0 * 1.2 + textSize0 * const * 2.0, width: padding1, height: textSize0 * const))
        password.center.x = view.center.x
        password.layer.cornerRadius = 10.0
        password.borderStyle = .bezel
        password.placeholder = " password"
        password.font = UIFont(name: "Farah", size: textSize0)
        password.autocorrectionType = .no
        password.autocapitalizationType = .none
        password.spellCheckingType = .no
        password.isSecureTextEntry = true
        password.delegate = self
        view.addSubview(password)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        goProcess()
        return true
    }
    
    // MARK: SegmentedController setup
    func setUpSelector() {
        selector = UISegmentedControl(frame: CGRect(x: 0.0, y: padding0 * 1.0 + textSize0 * const * 0.0, width: padding1, height: textSize0 *  const))
        selector.center.x = view.center.x
        selector.insertSegment(withTitle: options[0], at: 0, animated: true)
        selector.insertSegment(withTitle: options[1], at: 1, animated: true)
        selector.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        selector.selectedSegmentIndex = 0
        selector.addTarget(self, action: #selector(changeOptions), for: .allEvents)
        view.addSubview(selector)
    }
    
    @objc func changeOptions() {
        changeButtonTitle()
        updateDescriptor(newText: selector.titleForSegment(at: selector.selectedSegmentIndex)!)
    }
    
    func changeButtonTitle() {
        goButton.setTitle(selector.titleForSegment(at: selector.selectedSegmentIndex), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
