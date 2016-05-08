//
//  DetailViewController.swift
//  Lifetime
//
//  Created by Nils Fischer on 29.04.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Contacts

class ContactDetailViewController: UIViewController {

    /// The contact whose details to display
    var contact: CNContact? {
        didSet {
            self.configureView()
        }
    }
    
    
    // MARK: Interface Elements
    
    @IBOutlet private var lifetimeTitleLabel: UILabel!
    @IBOutlet private var lifetimeLabel: UILabel!
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateTimerFired(_:)), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        updateTimer?.invalidate()
        updateTimer = nil
    }

    private func configureView() {
        guard isViewLoaded() else { return }
        if let contact = self.contact, fullName = CNContactFormatter.stringFromContact(contact, style: .FullName) {
            self.title = fullName
            lifetimeTitleLabel.text = "\(contact.givenName ?? fullName)'s total lifetime is"
        } else {
            self.title = nil
            lifetimeTitleLabel.text = nil
        }
        updateLifetimeDisplay()
    }
    

    // MARK: Updates
    
    private var updateTimer: NSTimer?
    
    @objc private func updateTimerFired(timer: NSTimer) {
        updateLifetimeDisplay()
    }
    
    private func updateLifetimeDisplay() {
        if let birthdayComponents = contact?.birthday, birthday = NSCalendar.currentCalendar().dateFromComponents(birthdayComponents) {
            let lifetimeFormatter = NSDateComponentsFormatter()
            lifetimeFormatter.allowedUnits = NSCalendarUnit.Day.union(.Hour).union(.Minute).union(.Second)
            lifetimeFormatter.unitsStyle = .SpellOut
            lifetimeLabel.text = lifetimeFormatter.stringFromDate(birthday, toDate: NSDate())
        } else {
            lifetimeLabel.text = nil
        }
    }
}

