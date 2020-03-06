//
//  SignUpController.swift
//  RedAction
//
//  Created by Ruzanna Sedrakyan on 7/29/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

protocol SuccessMessageDelegate : class {
    func showSuccessMessage(_ controller: UIViewController, message: String)
}

class SignUpController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var genderView: UIView!
    @IBOutlet var prenomView: UIView!
    @IBOutlet var nomView: UIView!
    @IBOutlet var emailView: UIView!
    @IBOutlet var passwordView: UIView!
    @IBOutlet var countryView: UIView!
    @IBOutlet var prenomTextfield: UITextField!
    @IBOutlet var nomTextfield: UITextField!
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var countryTextfield: UITextField!
    
    @IBOutlet var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        startObservingKeyboardChanges()
        
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        
        setLayoutSubviews()
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        if Validations.isTextFieldTextEmpty(nomTextfield.text) || Validations.isTextFieldTextEmpty(prenomTextfield.text) || Validations.isTextFieldTextEmpty(emailTextfield.text) {
            return makeAlertAppear(title: "Error Email Validation", message: "Your fields are empty.", actionTitle: "OK")
        // } else if Validations.isValidEmail(emailTextfield.text) {
//            return makeAlertAppear(title: "Error Email Validation", message: "Your email address is invalid.", actionTitle: "OK")
        } else
        {
            let userData = User.init(first_name: prenomTextfield.text!, last_name: nomTextfield.text!, email: emailTextfield.text!, password: passwordTextfield.text!, username: emailTextfield.text!)
            APIManager.sharedInstance.registerUser(parameters: userData) { (error, statusCode) in
                if let error = error {
                    // got an error in getting the data, need to handle it
                    print("error calling POST request")
                    print(error)
                    return
                }
                
                if let statusCode = statusCode {
                    print("Statuscode is \(statusCode)")
                    switch statusCode {
                    case 201:
                        self.dismiss(animated: true, completion: nil)
                    case 400:
                        return self.makeAlertAppear(title: "Désolé. Une erreur est survenue.", message: "Veuillez réessayer.", actionTitle: "OK")
                    case 401:
                        return self.makeAlertAppear(title: "Désolé. Une erreur est survenue.", message: "Veuillez réessayer.", actionTitle: "OK")
                    case 500:
                        return self.makeAlertAppear(title: "Cette adresse e-mail existe déjà.", message: "Veuillez réessayer de vous inscrire avec une autre adresse e-mail ou cliquez ici pour vous connecter avec cette adresse e-mail.", actionTitle: "OK")
                    default:
                        print("default")
                    }
                }
            }
        }
        
    }
    
    // UITextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case prenomTextfield:
            prenomTextfield.resignFirstResponder()
        case nomTextfield:
            nomTextfield.resignFirstResponder()
        case emailTextfield:
            emailTextfield.resignFirstResponder()
        case passwordTextfield:
            passwordTextfield.resignFirstResponder()
        case countryTextfield:
            countryTextfield.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    // NotificationCenter observers
    private func startObservingKeyboardChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func makeRightBarButtonItem() {
        let sortButton = UIButton(frame: CGRect(x: 0, y: 0, width: 110, height: 25))
        sortButton.setTitle("FAIRE UN DON", for: .normal)
        sortButton.titleLabel?.font = UIFont(name: "Calibri", size: 15)
        sortButton.setTitleColor(.white, for: .normal)
        sortButton.layer.cornerRadius = 5
        sortButton.backgroundColor = UIColor (red: 232/255.0, green: 181/255.0, blue: 40/255.0, alpha: 1)
        let item = UIBarButtonItem(customView: sortButton);
        self.navigationItem.setRightBarButtonItems([item], animated: false);
        item.customView?.widthAnchor.constraint(equalToConstant: 110).isActive = true;
        item.customView?.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    private func makeLeftBarButtonItem() {
        let btn = UIButton(type: .custom);
        btn.setImage(UIImage(named: "redaction-logo-mobile"), for: .normal);
        
        btn.frame = CGRect(x: 0, y: 0, width: 150, height: 30);
        let item = UIBarButtonItem(customView: btn);
        self.navigationItem.setLeftBarButtonItems([item], animated: false);
        
        item.customView?.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        item.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true;
    }
    
    // Make view settings
    private func configureView() {
        
        makeRightBarButtonItem()
        makeLeftBarButtonItem()
        
        prenomTextfield.delegate = self
        nomTextfield.delegate = self
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        countryTextfield.delegate = self
        
        prenomTextfield.attributedPlaceholder = NSAttributedString(string: "Prénom",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor (red: 114/255.0, green: 114/255.0, blue: 107/255.0, alpha: 1)])
        
        nomTextfield.attributedPlaceholder = NSAttributedString(string: "Nom",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor (red: 114/255.0, green: 114/255.0, blue: 107/255.0, alpha: 1)])
        
        emailTextfield.attributedPlaceholder = NSAttributedString(string: "E-mail",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor (red: 114/255.0, green: 114/255.0, blue: 107/255.0, alpha: 1)])
        
        passwordTextfield.attributedPlaceholder = NSAttributedString(string: "Mot de passe",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor (red: 114/255.0, green: 114/255.0, blue: 107/255.0, alpha: 1)])
        countryTextfield.attributedPlaceholder = NSAttributedString(string: "Country",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor (red: 114/255.0, green: 114/255.0, blue: 107/255.0, alpha: 1)])
        
        okButton.clipsToBounds = true
        genderView.clipsToBounds = true
        prenomView.clipsToBounds = true
        nomView.clipsToBounds = true
        emailView.clipsToBounds = true
        passwordView.clipsToBounds = true
        countryView.clipsToBounds = true
    }
    
    // Set layout subviews
    private func setLayoutSubviews() {
        
        okButton.layer.cornerRadius = 5
        genderView.layer.cornerRadius = 5
        prenomView.layer.cornerRadius = 5
        nomView.layer.cornerRadius = 5
        emailView.layer.cornerRadius = 5
        passwordView.layer.cornerRadius = 5
        countryView.layer.cornerRadius = 5
    }
    
    // Make alert appear
    private func makeAlertAppear(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
