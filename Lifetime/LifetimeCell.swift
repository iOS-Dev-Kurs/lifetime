//
//  LifetimeCell.swift
//  Lifetime
//
//  Created by Nils Fischer on 30.04.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Contacts

class LifetimeCell: UITableViewCell {
    
    func configure(for contact: CNContact) {
        textLabel?.text = CNContactFormatter.string(from: contact, style: .fullName)
        if let lifetime = contact.lifetime {
            let lifetimeFormatter = DateComponentsFormatter()
            lifetimeFormatter.allowedUnits = .day
            lifetimeFormatter.unitsStyle = .full
            detailTextLabel?.text = lifetimeFormatter.string(from: lifetime)
        } else {
            detailTextLabel?.text = nil
        }
    }
    
}
