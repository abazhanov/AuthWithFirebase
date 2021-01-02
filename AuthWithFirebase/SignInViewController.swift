//
//  SignInViewController.swift
//  AuthWithFirebase
//
//  Created by Artem Bazhanov on 31.12.2020.
//

import UIKit
import Firebase
import FirebaseAuth


class SignInViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0

        // Do any additional setup after loading the view.
    }
    
    
    func chechValid () -> String?{
        if firstNameTextField.text == "" ||
           lastNameTextField.text == "" ||
           emailTextField.text == "" ||
           passwordTextFiled.text == "" ||
           firstNameTextField.text == nil ||
           lastNameTextField.text == nil ||
           emailTextField.text == nil ||
           passwordTextFiled.text == nil
           {
            return "Please fill in all fiels"
           }
        return nil
    }

    @IBAction func signInPressed(_ sender: Any) {
        let error = chechValid()
        print ("error = \(error)")
        
        if error != nil {
            errorLabel.alpha = 1
            errorLabel.text = error
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextFiled.text!) { (result, error) in
                print("error in closure = \(error)")
                print("result in closure = \(result)")
                
                if error != nil {
                    self.errorLabel.text = "\(error?.localizedDescription)"
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "firstname": self.firstNameTextField.text!,
                        "lastname": self.lastNameTextField.text!,
                        "uid": result!.user.uid
                        
            
                    ]) { (error) in
                        if error != nil {
                            fatalError("Error saving user in database")
                        }
                    }
                    
                    print("Jump to the next screen")
                }
            } //end
        }
        
        
    }
    
}
