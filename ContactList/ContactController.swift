//
//  ContactController.swift
//  ContactList
//
//  Created by Andrew Ervin Gierke on 2/24/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    //MARK: - Properties
    
    static let shared = ContactController()
    
    private let cloudKitManager = CloudKitManager()
    
    var contacts = [Contact]() {
        didSet {
            DispatchQueue.main.async {
                let notificationCenter = NotificationCenter.default
                notificationCenter.post(name: Keys.DidRefreshNotificaiton, object: self)
            }
        }
    }
    
    //MARK: - View Life
    
    init() {
        refreshData()
    }
    
    
    //MARK: - CRUD
    
    // Create
    
    func create(contact: Contact, completion: @escaping ((Error?) -> Void) = { _ in }) {
        let record = contact.cloudKitRecord
        cloudKitManager.save(record) { (error) in
            defer { completion(error) }
            if let error = error {
                NSLog(error.localizedDescription)
                return
            }
            self.contacts.append(contact)
        }
    }
    
    // RefreshData
    
    func refreshData(completion: @escaping ((Error?) -> Void) = { _ in }) {
        let sortDescriptors = [NSSortDescriptor(key: Keys.nameKey, ascending: false)]
        cloudKitManager.fetchRecords(ofType: Keys.contactRecordType, withSortDescriptors: sortDescriptors) { (records, error) in
            defer { completion(error) }
            if let error = error {
                NSLog(error.localizedDescription)
                return
            }
            guard let records = records else { return }
            self.contacts = records.flatMap{ Contact(cloudKitRecord: $0) }
        }
    }
    

    // Subscribe
    
    func subscribeToPushNotifications(completion: @escaping ((Error?) -> Void) = { _ in }) {
        cloudKitManager.subscribeToCreationOfRecords(withType: Keys.contactRecordType) { (error) in
            if let error = error {
                NSLog(error.localizedDescription)
            }
            completion(error)
        }
    }
}






















