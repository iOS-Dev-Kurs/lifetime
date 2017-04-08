//
//  AppDelegate.swift
//  Lifetime
//
//  Created by Nils Fischer on 29.04.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Contacts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // find root view controller
        let contactListViewController = (window!.rootViewController as! UINavigationController).topViewController as! ContactListViewController
        
        // obtain reference to device contacts
        let contactStore = CNContactStore()
        
        // request authorization to access contacts if necessary, then pass on the contact store
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            contactListViewController.contactStore = contactStore
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { success, error in
                if success {
                    contactListViewController.contactStore = contactStore
                } else {
                    print(error!)
                }
            }
        case .denied, .restricted:
            break
        }
        
        return true
    }

}
