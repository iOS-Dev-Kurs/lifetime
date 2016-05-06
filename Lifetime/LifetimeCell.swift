//
//  LifetimeCell.swift
//  Lifetime
//
//  Created by Marvin A. Ruder on 5/6/16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import UIKit
import Contacts

class LifetimeCell: UITableViewCell {
    func configureForContact(contact: CNContact) {
        textLabel?.text = CNContactFormatter.stringFromContact(contact, style: .FullName)
        if let lifetime = contact.lifetime where contact.birthday?.year != 9223372036854775807 {
            let lifetimeFormatter = NSDateComponentsFormatter()
            lifetimeFormatter.allowedUnits = .Day
            lifetimeFormatter.unitsStyle = .Full
            detailTextLabel?.text = lifetimeFormatter.stringFromTimeInterval(lifetime)
        } else if let birthdayComponents = contact.birthday where birthdayComponents.year == 9223372036854775807 {
            detailTextLabel?.text = "Birthday on \(birthdayComponents.month)/\(birthdayComponents.day)"
        } else {
            detailTextLabel?.text = nil
        }
    }
}