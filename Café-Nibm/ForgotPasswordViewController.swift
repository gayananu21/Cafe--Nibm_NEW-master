//
//  ForgotPasswordViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 2/22/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class ForgotPasswordViewController: UIViewController {

            @IBOutlet weak var emailTextField: UITextField!
            
            @IBOutlet weak var errorLabel: UILabel!
            
            override func viewDidLoad() {
            super.viewDidLoad()
                
            self.navigationController?.navigationBar.alpha = 1

            // Do any additional setup after loading the view.
            self.emailTextField.addBottomBorder()
                
                
            //Looks for single or multiple taps.
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

                                  //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
                                  //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
                
        
    }
    

  
    // MARK: - Dismissing keyboard when tap on screen

    @objc func dismissKeyboard() {
                //Causes the view (or one of its embedded text fields) to resign the first responder status.
                view.endEditing(true)
            }
    
    // MARK: - Creating a spinng view

    func createSpinnerView() {
          let child = SpinnerViewController()

          // add the spinner view controller
          addChild(child)
          child.view.frame = view.frame
          view.addSubview(child.view)
          child.didMove(toParent: self)

          // wait two seconds to simulate some work happening
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              // then remove the spinner view controller
              child.willMove(toParent: nil)
              child.view.removeFromSuperview()
              child.removeFromParent()
          }
      }
       

    @IBAction func reset_passwordClicked(_ sender: Any) {
        
        createSpinnerView()
        
        self.errorLabel.alpha = 1
        let email = self.emailTextField.text ?? ""
               
               Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                 if let error = error as? NSError {
                   switch AuthErrorCode(rawValue: error.code) {
                   case .userNotFound:
                     // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                           self.errorLabel.text = "The email address is badly formatted"
                   case .invalidEmail:
                     // Error: The email address is badly formatted.
                    let alert = UIAlertController(title: "ERROR", message: "\(self.errorLabel.text ?? "")", preferredStyle: .alert)
                                                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                                      
                                                                                               

                                                                                 }))
                                                                                                     self.present(alert, animated: true, completion: nil)
                    
                            self.errorLabel.text = "The email address is badly formatted"
                   case .invalidRecipientEmail:
                     // Error: Indicates an invalid recipient email was sent in the request.
                       self.errorLabel.text = "Indicates an invalid recipient email was sent in the request"
                    let alert = UIAlertController(title: "ERROR", message: "\(self.errorLabel.text ?? "")", preferredStyle: .alert)
                                                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                                      
                                                                                               

                                                                                 }))
                                                                                                     self.present(alert, animated: true, completion: nil)
                    
                    
                   case .invalidSender:
                     // Error: Indicates an invalid sender email is set in the console for this action.
                       self.errorLabel.text = "The email address is badly formatted"
                    let alert = UIAlertController(title: "ERROR", message: "\(self.errorLabel.text ?? "")", preferredStyle: .alert)
                                                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                                      
                                                                                               

                                                                                 }))
                                                                                                     self.present(alert, animated: true, completion: nil)
                    
                   case .invalidMessagePayload:
                     // Error: Indicates an invalid email template for sending update email.
                       self.errorLabel.text = "Indicates an invalid email template for sending update email"
                    let alert = UIAlertController(title: "ERROR", message: "\(self.errorLabel.text ?? "")", preferredStyle: .alert)
                                                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                                      
                                                                                               

                                                                                 }))
                                                                                                     self.present(alert, animated: true, completion: nil)
                    
                   default:
                       
                     print("Error message: \(error.localizedDescription)")
                       self.errorLabel.text = "Error unable to send verification email"
                    let alert = UIAlertController(title: "ERROR", message: "\(self.errorLabel.text ?? "")", preferredStyle: .alert)
                                                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                                      
                                                                                               

                                                                                 }))
                                                                                                     self.present(alert, animated: true, completion: nil)
                    
                   }
                 } else {
                   print("Reset password email has been successfully sent")
                   self.errorLabel.text = "Reset password email has been successfully sent"
                    let alert = UIAlertController(title: "ERROR", message: "\(self.errorLabel.text ?? "")", preferredStyle: .alert)
                                                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                                      
                                                                                               

                                                                                 }))
                                                                                                     self.present(alert, animated: true, completion: nil)
                    
                 }
               }
    }
}

extension UITextField {
    func addBottomBorder2(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: 1200, height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
