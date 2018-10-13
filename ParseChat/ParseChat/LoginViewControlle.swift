//
//  LoginViewControlle.swift
//  ParseChat
//
//  Created by Anirudh V on 10/6/18.
//  Copyright © 2018 Julie Bao. All rights reserved.
//

import UIKit
import Parse
class LoginViewControlle: UIViewController {

    @IBOutlet weak var PassWordField: UITextField!
    @IBOutlet weak var UsernameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func OnSignup(_ sender: Any) {
        let newUser = PFUser()
        
        // set user properties
        newUser.username = UsernameField.text
        newUser.password = PassWordField.text
        
        // checks if empty
        if (newUser.username == "" || newUser.password == "")
        {
            createAlert(title: "Empty Field", message: "Please enter both username and password")
        }
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                self.createAlert(title : "User Already Exist", message : "PLease Click Login")
                
            } else {
                print("User Registered successfully")
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                // manually segue to logged in view
            }
        }
    }
    
    @IBAction func OnLogin(_ sender: Any) {
        let username = UsernameField.text ?? ""
        let password = PassWordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                self.createAlert(title : "Wrong Credentials", message : "Try Again with Correct Credentials")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createAlert(title : String, message : String){
        let Alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        Alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in Alert.dismiss(animated: true, completion: nil)}))
        self.present(Alert, animated: true, completion: nil)
    }
    
}
