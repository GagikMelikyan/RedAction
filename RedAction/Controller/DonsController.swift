//
//  DonsController.swift
//  RedAction
//
//  Created by Ruzanna Sedrakyan on 11/29/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class DonsController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var redActionImage: UIImageView!
    @IBOutlet var ammountTextField: UITextField!
    @IBOutlet var paypalButton: UIButton!
    @IBOutlet var emailView: UIView!
    @IBOutlet var cardNumberAndNumbersView: UIView!
    @IBOutlet var cardNumberView: UIView!
    @IBOutlet var dateView: UIView!
    @IBOutlet var cbButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var cardNumberTextField: UITextField!
    @IBOutlet var mmAATextField: UITextField!
    @IBOutlet var numbersTextField: UITextField!
    
    var currentString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        setLayoutSubviews()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case ammountTextField:
            ammountTextField.resignFirstResponder()
        case emailTextField:
            emailTextField.resignFirstResponder()
        case cardNumberTextField:
            cardNumberTextField.resignFirstResponder()
        case mmAATextField:
            mmAATextField.resignFirstResponder()
        case numbersTextField:
            numbersTextField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == ammountTextField {
            switch string {
            case "0","1","2","3","4","5","6","7","8","9":
                currentString += string
                formatCurrency(currentString)
            default:
                if string.count == 0 && currentString.count != 0 {
                    currentString = String(currentString.dropLast())
                    formatCurrency(currentString)
                }
            }
            return false
            
        }
        return true
    }
    
    func formatCurrency(_ string: String) {
        print("format \(string)")
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = findLocaleByCurrencyCode("EUR")
        let numberFromField = (NSString(string: currentString).doubleValue)
        let temp = formatter.string(from: numberFromField as NSNumber)! as NSString
        ammountTextField.text = String(describing: temp)
    }
    
    func findLocaleByCurrencyCode(_ currencyCode: String) -> Locale? {
        
        let locales = Locale.availableIdentifiers
        var locale: Locale?
        for   localeId in locales {
            locale = Locale(identifier: localeId)
            if let code = (locale! as NSLocale).object(forKey: NSLocale.Key.currencyCode) as? String {
                if code == currencyCode {
                    return locale
                }
            }
        }
        return locale
        
    }
    
    // Make view settings
    private func configureView() {
        
        redActionImage.clipsToBounds = true
        paypalButton.clipsToBounds = true
        emailView.clipsToBounds = true
        cardNumberAndNumbersView.clipsToBounds = true
        emailView.clipsToBounds = true
        cbButton.clipsToBounds = true
        
        let borderColor : UIColor = UIColor( red: 174/255.0, green: 174/255.0, blue: 174/255.0, alpha: 1)
        emailView.layer.masksToBounds = true
        emailView.layer.borderColor = borderColor.cgColor
        
        cardNumberAndNumbersView.layer.masksToBounds = true
        cardNumberAndNumbersView.layer.borderColor = borderColor.cgColor
        
        dateView.layer.masksToBounds = true
        dateView.layer.borderColor = borderColor.cgColor
        
        ammountTextField.delegate = self
        emailTextField.delegate = self
        cardNumberTextField.delegate = self
        mmAATextField.delegate = self
        numbersTextField.delegate = self
    }
    
    // Set layout subviews
    private func setLayoutSubviews() {
        
        redActionImage.layer.cornerRadius = 3
        paypalButton.layer.cornerRadius = 5
        emailView.layer.cornerRadius = 5
        cardNumberAndNumbersView.layer.cornerRadius = 5
        dateView.layer.cornerRadius = 5
        cbButton.layer.cornerRadius = 5
        
        emailView.layer.borderWidth = 1.0
        cardNumberAndNumbersView.layer.borderWidth = 1.0
        dateView.layer.borderWidth = 1.0
        
        cardNumberView.layoutIfNeeded()
        cardNumberView.layer.addBorder(edge: .bottom, color: UIColor( red: 174/255.0, green: 174/255.0, blue: 174/255.0, alpha: 1), thickness: 1.0)
        
    }
}
