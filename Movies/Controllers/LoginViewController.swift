//
//  LoginViewController.swift
//  Movies
//
//  Created by Vaibhav Gawde on 08/06/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIView!
    @IBOutlet weak var registrationButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loginButton.setOnClickListener {
            guard let name = self.usernameTF.text else {
                print("enter username")
                return
            }
            
            guard let password = self.passwordTF.text else {
                print("enter password")
                return
            }
        }
        
        registrationButton.setOnClickListener {
            let stroyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newVC = stroyBoard.instantiateViewController(withIdentifier: "Registration") as! RegistrationViewController
            
            self.navigationController?.pushViewController(newVC, animated: true)
        }
        
    }
    

    
    
    @objc
    func loginCLick(sender : UIGestureRecognizer){
        
       
        
    }

    
}
