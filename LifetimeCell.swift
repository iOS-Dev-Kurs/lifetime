//
//  LifetimeCell.swift
//  Lifetime
//
//  Created by Kleimaier, Dennis on 02.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//
import Foundation
import UIKit
import Contacts

class LifetimeCell: UITableView{
    
    func configureForContact(contact: CNContact){
        textLabel?.text = CNContactFormatter.stringFromContact(contact, style: .FullName)
        if let lifetime = contact.lifetime {
            let lifetimeFormatter = NSDateComponentsFormatter()
            lifetimeFormatter.allowedUnits = .Day
            lifetimeFormatter.unitsStyle = .Full
            detailTextLabel?.text = lifetimeFormatter.stringFromTimeInterval(lifetimeFormatter)
        } else {
            detailTextLabel?.text = nil
        }
    }
}