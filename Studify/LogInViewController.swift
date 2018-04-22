//
//  LogInViewController.swift
//  Studify
//
//  Created by Rosalie Wessels on 13/04/2018.


import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil{
                print(error!)
            }
            else{
                print("Login succesful!")
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "GoToStudifyOverview", sender: self)
            }
        }
        
        //TODO: Log in the user
        
        
    }
    


    
}  
