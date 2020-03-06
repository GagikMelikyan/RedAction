//
//  MenuPopOverViewController.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 12/13/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class MenuPopOverViewController: UITableViewController {   // delete
    
    var menuTitles: [String] = ["Mon profil ", "Le média Red'Action", "Nous contacter", "Aide"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        
        cell.textLabel?.text = menuTitles[indexPath.row]
        
        return cell
    }
    
}
