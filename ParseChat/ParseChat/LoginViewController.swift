//
//  ViewController.swift
//  ParseChat
//
//  Created by Julie Bao on 9/21/18.
//  Copyright © 2018 Julie Bao. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
   
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //createAlert(title: "test", message: "messge")
    }
    
    @IBAction func Signup(_ sender: Any)
    {
        //SIGNUP
        // initialize a user object
        let newUser = PFUser()
    
        //set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
      //  if(newUser.username == "" || newUser.password == "") //if username or password is empty
        //{
          //  self.createAlert(title: "Missing Fields", message: "Please enter both username and password.")
        //}

        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
    }
    
    @IBAction func Login(_ sender: Any)
    {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                self.createAlert(title: "login failed", message: "Wrong credentials")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    func createAlert(title: String, message: String){
    let Alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    Alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in Alert.dismiss(animated: true, completion: nil)}))
        self.present(Alert, animated: true, completion: nil)}


}

