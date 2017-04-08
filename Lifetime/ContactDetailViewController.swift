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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerFired(_:)), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        updateTimer?.invalidate()
        updateTimer = nil
    }

    fileprivate func configureView() {
        guard isViewLoaded else { return }
        if let contact = self.contact, let fullName = CNContactFormatter.string(from: contact, style: .fullName) {
            self.title = fullName
            lifetimeTitleLabel.text = "\(contact.givenName)'s total lifetime is"
        } else {
            self.title = nil
            lifetimeTitleLabel.text = nil
        }
        updateLifetimeDisplay()
    }
    

    // MARK: Updates
    
    private var updateTimer: Timer?
    
    @objc private func updateTimerFired(_ timer: Timer) {
        updateLifetimeDisplay()
    }
    
    private func updateLifetimeDisplay() {
        if let birthdayComponents = contact?.birthday, let birthday = Calendar.current.date(from: birthdayComponents) {
            let lifetimeFormatter = DateComponentsFormatter()
            lifetimeFormatter.allowedUnits = NSCalendar.Unit.day.union(.hour).union(.minute).union(.second)
            lifetimeFormatter.unitsStyle = .spellOut
            lifetimeLabel.text = lifetimeFormatter.string(from: birthday, to: Date())
        } else {
            lifetimeLabel.text = nil
        }
    }

}

