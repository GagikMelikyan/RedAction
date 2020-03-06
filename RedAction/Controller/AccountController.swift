//
//  AccountController.swift
//  RedAction
//
//  Created by Ruzanna Sedrakyan on 11/18/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class AccountController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var circleLabel: UILabel!
    @IBOutlet var registerButton: UIButton!
    
    let imageNames = ["Civilite", "Prenom-1", "Nom-1", "Email", "Telephone", "Pays", "Language", "Padlock-1"]
    let cellTitles = ["Civilité", "Prénom", "Nom", "E-mail", "Téléphone", "Pays", "Langue principale", "Mot de passe"]
    let accountInfo = ["Monsieur", "John", "Smith", "redaction@gmail.com", "06 07 08 09 10", "France", "Francais", "redaction"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        setLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! AccountCell
        
        cell.cellImageView.image = UIImage(named: imageNames[indexPath.row])
        cell.cellLabel.text = cellTitles[indexPath.row]
        cell.cellTextField.text = accountInfo[indexPath.row]
        
        if indexPath.row == 7 {
            cell.cellTextField.isSecureTextEntry = true
        }
        
        return cell
    }
    
    // Make view settings
    private func configureView() {
        
        makeRightBarButtonItem()
        makeLeftBarButtonItem()
        
        circleLabel.layer.masksToBounds = true
        registerButton.clipsToBounds = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    // Set layout subviews
    private func setLayoutSubviews() {
        circleLabel.layer.cornerRadius = circleLabel.frame.width / 2
        registerButton.layer.cornerRadius = 10
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
