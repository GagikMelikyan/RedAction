//
//  Extensions.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 11/15/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UICollectionViewCell {
    func configureCell() {

        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 1.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
}

extension UILabel{
    func setSubTextColor(pSubString : String, textColor : UIColor, backgroundColor : UIColor){
        let attributedString: NSMutableAttributedString = self.attributedText != nil ? NSMutableAttributedString(attributedString: self.attributedText!) : NSMutableAttributedString(string: self.text!);
        
        let range = attributedString.mutableString.range(of: pSubString, options:NSString.CompareOptions.caseInsensitive)
        if range.location != NSNotFound {
            let font = UIFont.systemFont(ofSize: 11)
            let attributes: [NSAttributedStringKey: Any] = [
                NSAttributedStringKey.font: font,
                NSAttributedStringKey.foregroundColor: textColor,
                NSAttributedStringKey.backgroundColor: backgroundColor,
            ]
            attributedString.addAttributes(attributes, range: range)
        }
        self.attributedText = attributedString
    }
}

extension UIImage {
    
    static func triangle(side: CGFloat, color: UIColor)->UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: side, height: side), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        ctx.beginPath()
        ctx.move(to: CGPoint(x: side / 2, y: 0))
        //### Add lines
        ctx.addLine(to: CGPoint(x: side, y: side))
        ctx.addLine(to: CGPoint(x: 0, y: side))
        //ctx.addLine(to: CGPoint(x: side / 2, y: 0)) //### path is automatically closed
        ctx.closePath()
        
        ctx.setFillColor(color.cgColor)
        
        ctx.drawPath(using: .fill) //### draw the path
        
        ctx.restoreGState()
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return img
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIResponder {
    static var id: String {
        return String(describing: self)
    }
}

extension UITableView {
    func registerCells(names: [String]) {
        for name in names {
            register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
        }
    }
    
}

extension String {
    func maxLength(length: Int) -> String {
        var str = self
        let nsString = str as NSString
        if nsString.length >= length {
            str = nsString.substring(with:
                NSRange(
                    location: 0,
                    length: nsString.length > length ? length : nsString.length)
            )
        }
        return  str
    }
}

extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
        case .deferred:
            return "deferred"
        case .failed:
            return "failed"
        case .purchased:
            return "purchased"
        case .purchasing:
            return "purchasing"
        case .restored:
            return "restored"
        default:
            return "No state"
        }
    }
}
