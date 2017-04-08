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
    
    fileprivate var contacts: [CNContact] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private let requiredContactKeysToFetch = [ CNContactFormatter.descriptorForRequiredKeys(for: .fullName) ] + CNContact.requiredKeysForLifetime

    fileprivate func loadContacts(filteredBy searchTerm: String? = nil) {
        guard let contactStore = contactStore else {
            contacts = []
            return
        }
        if let searchTerm = searchTerm, !searchTerm.isEmpty {
            contacts = (try? contactStore.unifiedContacts(matching: CNContact.predicateForContacts(matchingName: searchTerm), keysToFetch: self.requiredContactKeysToFetch)) ?? []
        } else {
            let containers = (try? contactStore.containers(matching: nil)) ?? []
            contacts = containers.map({ CNContact.predicateForContactsInContainer(withIdentifier: $0.identifier) }).flatMap({ (try? contactStore.unifiedContacts(matching: $0, keysToFetch: self.requiredContactKeysToFetch)) ?? [] })
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
        tableView.tableHeaderView = searchController.searchBar
    }

    
    // MARK: User Interaction

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {

        // TODO: prepare segue.destinationViewController for each identifier
            
        default:
            break
        }
    }
    
}


// MARK: - Table View Datasource

// TODO: implement UITableViewDatasource protocol


// MARK: - Search Results Updating

extension ContactListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchTerm = searchController.searchBar.text, !searchTerm.isEmpty {
            loadContacts(filteredBy: searchTerm)
        } else {
            loadContacts(filteredBy: nil)
        }
    }
    
}
