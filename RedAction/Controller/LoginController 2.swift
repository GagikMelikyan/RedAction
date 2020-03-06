//
//  LoginController.swift
//  RedAction
//
//  Created by Ruzanna Sedrakyan on 7/25/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var connectButton: UIButton!
    @IBOutlet var registerView: UIView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        startObservingKeyboardChanges()
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        setLayoutSubviews()
    }
    
    // NotificationCenter observers
    private func startObservingKeyboardChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // UITextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextfield {
            passwordTextfield.becomeFirstResponder()
        } else if textField == passwordTextfield {
            passwordTextfield.resignFirstResponder()
        }
        return true
    }
    
    // Make view settings
    private func configureView() {
        
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        
        emailTextfield.attributedPlaceholder = NSAttributedString(string: "E-mail",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor (red: 114/255.0, green: 114/255.0, blue: 107/255.0, alpha: 1)])
        
        passwordTextfield.attributedPlaceholder = NSAttributedString(string: "Mot de passe",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor (red: 114/255.0, green: 114/255.0, blue: 107/255.0, alpha: 1)])
        
        connectButton.clipsToBounds = true
        registerView.clipsToBounds = true
    }
    
    // Set layout subviews
    private func setLayoutSubviews() {
        connectButton.layer.cornerRadius = 5
        registerView.layer.cornerRadius = 5
    }
}
