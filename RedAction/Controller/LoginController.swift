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
    
    @IBAction func loginAction(_ sender: UIButton) {
        _ = UserDefaults.standard.set(true, forKey: "firstUserConnected")
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
        
        makeRightBarButtonItem()
        makeLeftBarButtonItem()
        
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
    
    private func makeRightBarButtonItem() {
        let sortButton = UIButton(frame: CGRect(x: 0, y: 0, width: 95, height: 22))
        sortButton.setTitle("FAIRE UN DON", for: .normal)
        sortButton.titleLabel?.font = UIFont(name: "Calibri", size: 15)
        sortButton.setTitleColor(.white, for: .normal)
        sortButton.layer.cornerRadius = 2
        sortButton.backgroundColor = UIColor (red: 232/255.0, green: 181/255.0, blue: 40/255.0, alpha: 1)
        let item = UIBarButtonItem(customView: sortButton);
        self.navigationItem.setRightBarButtonItems([item], animated: false);
        item.customView?.widthAnchor.constraint(equalToConstant: 95).isActive = true;
        item.customView?.heightAnchor.constraint(equalToConstant: 22).isActive = true;
    }
    
    private func makeLeftBarButtonItem() {
        let btn = UIButton(type: .custom);
        btn.setImage(UIImage(named: "redaction-logo-mobile"), for: .normal);
        
        btn.frame = CGRect(x: 0, y: 0, width: 120, height: 25);
        let item = UIBarButtonItem(customView: btn);
        self.navigationItem.setLeftBarButtonItems([item], animated: false);
        
        item.customView?.widthAnchor.constraint(equalToConstant: 120).isActive = true;
        item.customView?.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
}
