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
    
    @nonobjc static let requiredKeysForLifetime: [CNKeyDescriptor] = [ CNContactBirthdayKey as CNKeyDescriptor ]
    
    var lifetime: TimeInterval? {
        guard let birthdayComponents = self.birthday,
            let birthday = Calendar.current.date(from: birthdayComponents) else {
                return nil
        }
        return Date().timeIntervalSince(birthday)
    }
    
}
