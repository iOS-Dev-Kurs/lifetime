//
//  ContactCell.swift
//  Lifetime
//
//  Created by Max Simon on 05.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Contacts

class ContactCell: UITableViewCell {
    
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSeconds: UILabel!
    
    var totalTime: Int = 0
    
    func updateSeconds() {
        self.totalTime += 1
        labelSeconds.text = String(self.totalTime) + "s"
    }
    
    func configureForContact(contact: CNContact) -> NSTimer? {
        labelName.text = contact.givenName + " " + contact.familyName
        if let timeSinceBirthday = contact.lifetimeInSeconds {
            totalTime = timeSinceBirthday
            let cellTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ContactCell.updateSeconds), userInfo: nil, repeats: true)
            return cellTimer
        }
        else {
            labelSeconds.text = ""
            return nil
        }
    }
}
