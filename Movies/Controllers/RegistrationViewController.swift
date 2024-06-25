//
//  RegistrationViewController.swift
//  Movies
//
//  Created by Vaibhav Gawde on 08/06/24.
//

import UIKit
import CoreData

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
        saveUser(name: username, password: password)
        self.navigationController?.popViewController(animated: true)

    }
    
    func saveUser(name: String, password: String){
        let user = Registration(context: PersistentStorage.Shared.context)
        user.name = name
        user.password = password
        PersistentStorage.Shared.saveContext()
    }
    
    
    

    

}
