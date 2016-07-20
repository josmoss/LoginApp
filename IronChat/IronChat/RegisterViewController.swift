//
//  RegisterViewController.swift
//  IronChat
//
//  Created by Joe Moss on 7/19/16.
//  Copyright © 2016 Iron Yard_Joe Moss. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userRegTextField: UITextField!
    
    @IBOutlet weak var passwordRegTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    func dismissKeyboard() {
        
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == self.userRegTextField {
            self.passwordRegTextField.becomeFirstResponder()
            
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

    @IBAction func registerButton(sender: UIButton) {
        
        if let userNew = userRegTextField.text {
            
            if let passwordNew = passwordRegTextField.text {
                
                self.createUser(userNew, password: passwordNew)
            }
            
        }
        
    }
    
}
