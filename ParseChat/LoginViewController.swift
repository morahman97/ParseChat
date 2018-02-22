//
//  ViewController.swift
//  ParseChat
//
//  Created by Mo on 2/21/18.
//  Copyright © 2018 Mo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var signUpOutlet: UIButton!
    @IBOutlet weak var loginOutlet: UIButton!
    
    let alertController = UIAlertController(title: "Login Failed", message: "Invalid login credentials", preferredStyle: .alert)

    // create an OK action
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        // handle response here.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        alertController.addAction(OKAction)
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        self.registerUser()
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.loginUser()
    }
    
    func loginUser() {
        if (usernameOutlet.text?.isEmpty)! || (passwordOutlet.text?.isEmpty)! {
            let alert1Controller = UIAlertController(title: "Login Failed", message: "Invalid login credentials", preferredStyle: .alert)

            let OK1Action = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            alert1Controller.addAction(OK1Action)
            present(alert1Controller, animated: true)
            return
        }
        let username = usernameOutlet.text ?? ""
        let password = passwordOutlet.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                //self.present(self.alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                    
                //}
                print("User log in failed: \(error.localizedDescription)")
                self.performSegue(withIdentifier: "showMain", sender: self)
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "showMain", sender: self)
            }
        }
    }
    
    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameOutlet.text
        newUser.password = passwordOutlet.text
        
        if (usernameOutlet.text?.isEmpty)! || (passwordOutlet.text?.isEmpty)! {
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                self.present(self.alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                
                self.performSegue(withIdentifier: "showMain", sender: self)
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

