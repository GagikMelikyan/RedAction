//
//  SideMenuViewController.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 12/7/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

struct Menu {
    var opened: Bool
    var title: String
    var iconName: String
    var sectionData: [String]
}

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource { //UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var menuData = [Menu(opened: false, title: "FAIRE UN DON", iconName: "Euro", sectionData: []),
                    Menu(opened: false, title: "S'ABONNER", iconName: "Subscribe", sectionData: ["Article 1", "Article 2"]),
                    Menu(opened: false, title: "Mes alerts", iconName: "mes_alertes", sectionData: ["Article 1", "Article 2"]),
                    Menu(opened: false, title: "Mes articles", iconName: "mes_articles", sectionData: ["Article 1", "Article 2"]),
                    Menu(opened: false, title: "Nous contacter", iconName: "Contact", sectionData: ["Article 1", "Article 2"]),
                    Menu(opened: false, title: "Rechercher", iconName: "Rechercher", sectionData: ["Article 1", "Article 2"]),
                    Menu(opened: false, title: "Se déconnecter", iconName: "Log_out", sectionData: []),
                    
                    Menu(opened: false, title: "A LA UNE", iconName: "A_la_une", sectionData: ["Article 1", "Article 2"]),
                    Menu(opened: false, title: "PREMIUM", iconName: "Premium", sectionData: ["Article 1", "Article 2"]),
                    Menu(opened: false, title: "S'INFORMER", iconName: "Information", sectionData: ["Article 1", "Article 2"]),
                    Menu(opened: false, title: "APPROFONDIR", iconName: "Approfondir", sectionData: ["Article 1", "Article 2"]),
                    Menu(opened: false, title: "DÉCOUVRIR", iconName: "Decouvrir", sectionData: ["Article 1", "Article 2"]),
                    Menu(opened: false, title: "AGIR", iconName: "Agir", sectionData: ["Article 1", "Article 2"])]
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IAPHolder.shared.getProducts()
        SetUpTableView()
        
    }
    
    // Go back to Home Screen
    @IBAction func actionCancel(_ sender: UIButton) {       
        self.dismiss(animated: true, completion: nil)
    }
    
    // Make settings of tableview
    private func SetUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCells(names: [MenuCell.id, MenuSectionCell.id])
        tableView.backgroundColor = .clear
    }
    
    // MARK: UITableViewDataSource & Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  menuData[section].opened {
            return menuData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 7 && indexPath.row == 0 {
            return 65
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionDataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuSectionCell.id, for: indexPath) as! MenuSectionCell
            cell.headerTitleLabel.text = menuData[indexPath.section].title
            cell.headerTitleImageView.image = UIImage(named: menuData[indexPath.section].iconName)
            if indexPath.section < 7 {
                cell.arrowImageView.isHidden = true
            } else if indexPath.section > 6 {
                cell.sepereatorVIew.isHidden = false
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.id, for: indexPath) as! MenuCell
            cell.titleLabel.text = menuData[indexPath.section].sectionData[sectionDataIndex]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section < 7 {
            print("Redirect Other ViewController")
            switch indexPath.section {
            case 1:
                IAPHolder.shared.purchaseProduct(product: .autoRenewingPurchase)
            default:
                IAPHolder.shared.restorePurchases()
            }
        } else  if indexPath.row == 0 {
//            let cell = tableView.cellForRow(at: indexPath) as! MenuSectionCell
            
            if menuData[indexPath.section].opened {
                menuData[indexPath.section].opened = false
//                cell.arrowImageView.transform = CGAffineTransform(rotationAngle: (180 * CGFloat(Double.pi)) / 180.0)
                let sections = IndexSet(integer: indexPath.section)
                tableView.reloadSections(sections, with: .automatic)
            } else {
                menuData[indexPath.section].opened = true
//                cell.arrowImageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
                let sections = IndexSet(integer: indexPath.section)
                tableView.reloadSections(sections, with: .automatic)
            }
        }
    }
        
}
