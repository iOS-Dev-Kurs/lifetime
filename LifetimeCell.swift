//
//  LifetimeCell.swift
//  Lifetime
//
//  Created by Libor, Julian Timo Andreas on 04.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Contacts

class LifetimeCell: UITableViewCell {
    
    func configureForContact(contact: CNContact) {
        textLabel?.text = CNContactFormatter.stringFromContact(contact, style: .FullName)
        if let lifetime = contact.lifetime {
            let lifetimeFormatter = NSDateComponentsFormatter()
            lifetimeFormatter.allowedUnits = .Day
            lifetimeFormatter.unitsStyle = .Full
            detailTextLabel?.text = lifetimeFormatter.stringFromTimeInterval(lifetime)
        } else {
            detailTextLabel?.text = nil
        }
    }
}