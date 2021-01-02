//
//  LoginViewController.swift
//  AuthWithFirebase
//
//  Created by Artem Bazhanov on 31.12.2020.
//

import UIKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            if error != nil {
                // error
                print("Ошибка логин пароль")
            } else {
                print("Jump to the next screen")
            }
        }
    }
    
}
