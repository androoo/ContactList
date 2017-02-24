//
//  ContactListTableViewController.swift
//  ContactList
//
//  Created by Andrew Ervin Gierke on 2/24/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    //MARK: - View Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(postsWereUpdated), name: Keys.DidRefreshNotificaiton, object: nil)
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.shared.contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.contactCellReuseIdentifier, for: indexPath)
        
        let contact = ContactController.shared.contacts[indexPath.row]
        cell.textLabel?.text = contact.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Notification revieved
    func postsWereUpdated() {
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Keys.contactDetailSegue {
            if segue.identifier == Keys.contactDetailSegue {
                guard let indexPath = tableView.indexPathForSelectedRow,
                    let contactDetailViewController = segue.destination as? ContactViewController else { return }
                
                let contact = ContactController.shared.contacts[indexPath.row]
                contactDetailViewController.contact = contact
            }
        }
    }
}
