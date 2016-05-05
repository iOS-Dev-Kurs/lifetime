//
//  Lifetime.swift
//  Lifetime
//
//  Created by Nils Fischer on 30.04.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Contacts


extension CNContact {
    
    @nonobjc static let requiredKeysForLifetime: [CNKeyDescriptor] = [ CNContactBirthdayKey ]
    
    var lifetime: NSTimeInterval? {
        guard let birthdayComponents = self.birthday,
            birthday = NSCalendar.currentCalendar().dateFromComponents(birthdayComponents) else {
                return nil
        }
        return NSDate().timeIntervalSinceDate(birthday)
    }
    
    var lifetimeInSeconds: Int? {
        guard let birthdate = self.birthday, birthdayAsNSObject = NSCalendar.currentCalendar().dateFromComponents(birthdate) else {
            return nil
        }
        let totalTime = NSDate().timeIntervalSinceDate(birthdayAsNSObject)
        return Int(totalTime)
    }
}
