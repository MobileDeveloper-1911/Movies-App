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
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        switch sender.tag {
                case 1:
                    guard let name = self.usernameTF.text else {
                        print("enter username")
                        return
                    }
                    
                    guard let password = self.passwordTF.text else {
                        print("enter password")
                        return
                    }
                    
                    self.getUserDetails(name: name, password: password)
                    
                 
                case 2 :
                    print("case 2")
                    let stroyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let newVC = stroyBoard.instantiateViewController(withIdentifier: "Registration") as! RegistrationViewController
                    
                    navigationController?.pushViewController(newVC, animated: true)
                default:
                    print("default")
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    
    
    
    func getUserDetails(name: String, password: String){
        do {
            guard let result = try PersistentStorage.Shared.context.fetch(Registration.fetchRequest()) as? [Registration] else {return}

            print(result.count)
            result.forEach { userData in
             
                if(name == userData.name && password == userData.password){
                  
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let newvc = storyboard.instantiateViewController(withIdentifier: "TabHomeController") as!
                        TabHomeViewController
                    
                    newvc.modalPresentationStyle = .fullScreen
                    self.present(newvc, animated: true)
                    
                    

                }else{
                    UserDefaults.standard.set(false, forKey: "isLoggedIn")
                    print("Please enter correct username password")

                }
            }
        }catch let error {
            print(error)
        }

    }
    


    
}
