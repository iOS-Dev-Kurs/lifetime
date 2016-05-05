//
//  MasterViewController.swift
//  Lifetime
//
//  Created by Nils Fischer on 29.04.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Contacts


class ContactListViewController: UITableViewController {

    /// A reference to the device's contacts
    var contactStore: CNContactStore? {
        didSet {
            loadContacts()
        }
    }

    
    // MARK: Contact Loading
    
    private var contacts: [CNContact] = [] {
        didSet {
            tableView.reloadData()
            print(contacts.count)
        }
    }

    private let requiredContactKeysToFetch = [ CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName) ] + CNContact.requiredKeysForLifetime

    private func loadContacts(filteredBy searchTerm: String? = nil) {
        guard let contactStore = contactStore else {
            contacts = []
            return
        }
        if let searchTerm = searchTerm where !searchTerm.isEmpty {
            contacts = (try? contactStore.unifiedContactsMatchingPredicate(CNContact.predicateForContactsMatchingName(searchTerm), keysToFetch: self.requiredContactKeysToFetch)) ?? []
        } else {
            let containers = (try? contactStore.containersMatchingPredicate(nil)) ?? []
            contacts = containers.map({ CNContact.predicateForContactsInContainerWithIdentifier($0.identifier) }).flatMap({ (try? contactStore.unifiedContactsMatchingPredicate($0, keysToFetch: self.requiredContactKeysToFetch)) ?? [] })
        }
    }
    
    
    // MARK: Search Controller
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        return searchController
    }()

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.tableHeaderView = searchController.searchBar
    }

    
    // MARK: User Interaction

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
            case "showInText":
            guard let indexPath = (self.view as! UITableView).indexPathForSelectedRow else { return }
            segue.destinationViewController.title = contacts[indexPath.row].givenName + " " + contacts[indexPath.row].familyName
            (segue.destinationViewController as! ContactDetailViewController).contact = contacts[indexPath.row]
            break

            
        default:
            break
        }
    }
    
    var cellTimers: [NSTimer] = []
    //override func viewDidDisappear(animated: Bool) {
    //    super.viewDidDisappear(animated)
    //    for timer in cellTimers {
    //        timer.invalidate()
    //    }
    //    cellTimers.removeAll()
    //}
    
    @IBAction func unwindToRoot(segue: UIStoryboardSegue) {
        // nothing to do
    }
    
}


// MARK: - Table View Datasource

// TODO: implement UITableViewDatasource protocol
extension ContactListViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    
    override func tableView(tableView: (UITableView!), cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let contact = contacts[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! ContactCell
        if let cellTimer = cell.configureForContact(contact) {
            self.cellTimers.append(cellTimer)
            cell.selectionStyle = .Default
            cell.accessoryType = .DisclosureIndicator
        } else {
            cell.selectionStyle = .None
            cell.accessoryType = .None
        }
        
        return cell
        
    }
}


// MARK: - Search Results Updating

extension ContactListViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchTerm = searchController.searchBar.text where !searchTerm.isEmpty {
            loadContacts(filteredBy: searchTerm)
        } else {
            loadContacts(filteredBy: nil)
        }
    }
    
}
