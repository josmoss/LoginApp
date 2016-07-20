//
//  ViewController.swift
//  IronChat
//
//  Created by Joe Moss on 7/19/16.
//  Copyright © 2016 Iron Yard_Joe Moss. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = FIRAuth.auth()?.currentUser {
            
            print("I am signed in as user\(user.email)")
            
            self.signOutUser()
            
        } else {
            
            print("I am not signed in")
            
//        self.signInUser("josmoss@gmail.com", password: "123456")
            
        }
        
//        self.createUser("josmoss@gmail.com", password: "123456")
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard() {
        
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        print(textField.text)
        
        if textField == self.userTextField {
            
            self.passwordTextField.becomeFirstResponder()
            
        } else {
            
            textField.resignFirstResponder()
            
        }
        
        return true
        
    }
    
    func createUser(email: String, password: String) {
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password) {
            
            (user, error) in
            
            if error != nil {
                print(error?.localizedDescription)
                
                
            }
            
            if let user = user {
                
                print(user.uid)
                print("Success! Create user \(email)")
            }
            
        }
        
    }
    
    func signOutUser() {
        
        try! FIRAuth.auth()!.signOut()
        
    }
    
    func signInUser(email: String, password: String) {
        
        FIRAuth.auth()?.signInWithEmail(email, password: password) {
            
            (user, error) in
            
            if error != nil {
                
                print(error?.localizedDescription)
                
                self.quickAlert()
                
            }
            
            if let user = user {
                
                print("\(user.email) signed in!")
                
                self.performSegueWithIdentifier("LoggedInSegue", sender: self)
                
            }
            
        }
        
    }
    
    func quickAlert() {
        
        let alert = UIAlertController(title: "Invalid Login", message: "", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Default) {
                                            (action) in
        }
        
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    @IBAction func loginTapped(sender: UIButton) {
        
        if let userCurrent = userTextField.text {

            if let passwordCurrent = passwordTextField.text {
                
                self.signInUser(userCurrent, password: passwordCurrent)
            }
            
        }
        
    }
    
    @IBAction func registerTapped(sender: UIButton) {
        
        performSegueWithIdentifier("RegisterSegue", sender: self)
        
    }

}

