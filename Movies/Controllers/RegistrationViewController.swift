//
//  RegistrationViewController.swift
//  Movies
//
//  Created by Vaibhav Gawde on 08/06/24.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passWordTF: UITextField!
    @IBOutlet weak var repeatPasswordTF: UITextField!
    @IBOutlet weak var loginButton : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isHidden = true
        
    }
    

    @IBAction func Submit(_ sender: UIButton) {
        
        guard let username = userNameTF.text else {
            print("Enter user name")
            return
        }
        
        guard let password = passWordTF.text else {
            print("Enter user password")
            return
        }
        
        
    }
    

}
