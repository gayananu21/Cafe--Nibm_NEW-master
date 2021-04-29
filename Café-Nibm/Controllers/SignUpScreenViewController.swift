//
//  SignUpScreenViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 2/22/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpScreenViewController: UIViewController, UIScrollViewDelegate {
    
     var refUsers: DatabaseReference!
    var user = Auth.auth().currentUser
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var registerButton: RoundButton!
    @IBOutlet weak var rPassLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    var uName = ""
    var uPhone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        // MARK: - Fading animation in signup
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseOut, animations: {
              self.nameLabel.alpha = 0
          }, completion: nil)
                
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseIn, animations: {
                    self.nameLabel.alpha = 1
                }, completion: nil)
        
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
              self.nameTextField.alpha = 0
          }, completion: nil)
                
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseIn, animations: {
                    self.nameTextField.alpha = 1
                }, completion: nil)
        
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
              self.emailLabel.alpha = 0
          }, completion: nil)
                
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseIn, animations: {
                    self.emailLabel.alpha = 1
                }, completion: nil)
        
        
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
              self.emailTextField.alpha = 0
          }, completion: nil)
                
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseIn, animations: {
                    self.emailTextField.alpha = 1
                }, completion: nil)
        
        
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseOut, animations: {
              self.phoneLabel.alpha = 0
          }, completion: nil)
                
        UIView.animate(withDuration: 1, delay: 0.3, options: .curveEaseIn, animations: {
                    self.phoneLabel.alpha = 1
                }, completion: nil)
        
        
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseOut, animations: {
              self.phoneTextField.alpha = 0
          }, completion: nil)
                
        UIView.animate(withDuration: 1, delay: 0.3, options: .curveEaseIn, animations: {
                    self.phoneTextField.alpha = 1
                }, completion: nil)
        
        
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseOut, animations: {
              self.passwordLabel.alpha = 0
          }, completion: nil)
                
        UIView.animate(withDuration: 1, delay: 0.4, options: .curveEaseIn, animations: {
                    self.passwordLabel.alpha = 1
                }, completion: nil)
        
        
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseOut, animations: {
              self.passwordTextField.alpha = 0
          }, completion: nil)
                
        UIView.animate(withDuration: 1, delay: 0.4, options: .curveEaseIn, animations: {
                    self.passwordTextField.alpha = 1
                }, completion: nil)
        
        
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseOut, animations: {
              self.rPassLabel.alpha = 0
          }, completion: nil)
                
        UIView.animate(withDuration: 1, delay: 0.4, options: .curveEaseIn, animations: {
                    self.rPassLabel.alpha = 1
                }, completion: nil)
        
        
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseOut, animations: {
              self.retypePasswordTextField.alpha = 0
          }, completion: nil)
                
        UIView.animate(withDuration: 1, delay: 0.4, options: .curveEaseIn, animations: {
                    self.retypePasswordTextField.alpha = 1
                }, completion: nil)
        
        
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseOut, animations: {
              self.registerButton.alpha = 0
          }, completion: nil)
                
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseIn, animations: {
                    self.registerButton.alpha = 1
                }, completion: nil)
        
        
        
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

                   //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
                   //tap.cancelsTouchesInView = false

             view.addGestureRecognizer(tap)
        
        
              self.emailTextField.addBottomBorder()
              self.passwordTextField.addBottomBorder()
              self.phoneTextField.addBottomBorder()
              self.nameTextField.addBottomBorder()
              self.retypePasswordTextField.addBottomBorder()
             
    }
    
   
    
    
    //Calls this function when the tap is recognized to dismiss keyboard
       
       @objc func dismissKeyboard() {
               //Causes the view (or one of its embedded text fields) to resign the first responder status.
               view.endEditing(true)
           }
    
    

    @IBAction func signupClicked(_ sender: Any) {
        
        
        self.errorLabel.alpha = 1
        
        let email = self.emailTextField.text ?? ""
              let password = self.passwordTextField.text ?? ""
        self.uName = self.nameTextField.text ?? ""
        self.uPhone = self.phoneTextField.text ?? ""
     
         
              let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
              let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
              
             Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
               if let error = error as? NSError {
                 switch AuthErrorCode(rawValue: error.code) {
                  
                 case .operationNotAllowed:
                  self.errorLabel.text = "Please enable Firebase Sign in method"
                   // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                    let alert = UIAlertController(title: "ERROR", message: "\(self.errorLabel.text ?? "")", preferredStyle: .alert)
                                                                      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                                                         
                                                                                                                  

                                                                                                    }))
                                                                                                                        self.present(alert, animated: true, completion: nil)
                 case .emailAlreadyInUse:
                  self.errorLabel.text = "The email address is already in use by another account"
                   // Error: The email address is already in use by another account.
                    let alert = UIAlertController(title: "ERROR", message: "\(self.errorLabel.text ?? "")", preferredStyle: .alert)
                                                                      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                                                         
                                                                                                                  

                                                                                                    }))
                                                                                                                        self.present(alert, animated: true, completion: nil)
                 
                 default:
                  self.errorLabel.text = "Error creating user!"
                     print("Error: \(error.localizedDescription)")
                    let alert = UIAlertController(title: "ERROR", message: "\(self.errorLabel.text ?? "")", preferredStyle: .alert)
                                                                      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                                                         
                                                                                                                  

                                                                                                    }))
                                                                                                                        self.present(alert, animated: true, completion: nil)
                 }
                  
                  if Utilities.isPasswordValid(cleanedPassword) == false {
                                                  // Password isn't secure enough
                                                 self.errorLabel.text =  "Please make sure your password is at least 8 characters, contains a special character and a number."
                    let alert = UIAlertController(title: "ERROR", message: "\(self.errorLabel.text ?? "")", preferredStyle: .alert)
                                                                      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                                                         
                                                                                                                  

                                                                                                    }))
                                                                                                                        self.present(alert, animated: true, completion: nil)
                                 if Utilities.isValidEmail(cleanedEmail) == false {
                                     // Password isn't secure enough
                                    self.errorLabel.text =  "Please enter a valid email"
                                    let alert = UIAlertController(title: "ERROR", message: "\(self.errorLabel.text ?? "")", preferredStyle: .alert)
                                                                                      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                                                                         
                                                                                                                                  

                                                                                                                    }))
                                                                                                                                        self.present(alert, animated: true, completion: nil)
                                 }
                                              }
                
                if(self.passwordTextField.text != self.retypePasswordTextField.text){
                    
                   // self.errorLabel.text =  "Your password not matching with retype password."
                    let alert = UIAlertController(title: "ERROR", message: "Your password not matching with retype password", preferredStyle: .alert)
                                                                      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                                                         
                                                                                                                  

                                                                                                    }))
                                                                                                                        self.present(alert, animated: true, completion: nil)
                    
                }

                
                
          
               }
                 
                                   
                             
               else {
                
             // MARK: - Saving user data to firebase
                
             self.user = Auth.auth().currentUser
                  let name = self.nameTextField.text ?? ""
                 let newUserInfo = Auth.auth().currentUser
              //  newUserInfo?.displayName = self.nameTextField.text
               // newUserInfo? .phoneNumber =  self.phoneTextField.text =
                //self.nameTextField.text = newUserInfo? .displayName
                
                self.refUsers = Database.database().reference()
                                                      

                                                            
                                                                //adding the artist inside the generated unique key
                self.refUsers.child("users").child(self.user?.uid ?? "").setValue(["name": self.uName, "phoneNumber": self.uPhone ,"userId": self.user?.uid ?? "", "imageUrl": "default"])
                
                
                
                             
                
                  print("User signs up successfully")
                 self.errorLabel.text = "User signs up successfully!"
                
                let alert = UIAlertController(title: "Success", message: "\(self.errorLabel.text ?? "")", preferredStyle: .alert)
                                                                  alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { action in
                                                                                                                     let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                                                                                            let vc = storyboard.instantiateViewController(withIdentifier: "LOGIN")
                                                                                                                            vc.modalPresentationStyle = .fullScreen
                                                                                                                            vc.modalTransitionStyle = .crossDissolve
                                                                                                                            self.present(vc, animated: true)
                                                                                                                            
                                                                                                              

                                                                                                }))
                                                                                                                    self.present(alert, animated: true, completion: nil)
                
               
               }
             }
    }
    
}




// MARK: - Here we can add bottom line to UITextField

extension UITextField {
    func addBottomBorder1(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: 1200, height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}

