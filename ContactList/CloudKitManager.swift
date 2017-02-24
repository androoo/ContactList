//
//  CloudKitManager.swift
//  ContactList
//
//  Created by Andrew Ervin Gierke on 2/24/17.
//  Copyright © 2017 Androoo. All rights reserved.
//


import Foundation
import CloudKit

class CloudKitManager {
    
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    func fetchRecords(ofType type: String, withSortDescriptors sortDescriptors: [NSSortDescriptor]? = nil, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        
        let query = CKQuery(recordType: type, predicate: NSPredicate(value: true))
        
        query.sortDescriptors = sortDescriptors
        
        publicDatabase.perform(query, inZoneWith: nil, completionHandler: completion)
        
    }
    
    func save(_ record: CKRecord, completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        publicDatabase.save(record) { (_, error) in
            
            completion(error)
        }
    }
    
    func subscribeToCreationOfRecords(withType type: String, completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        let subscription = CKQuerySubscription(recordType: type, predicate: NSPredicate(value: true), options: .firesOnRecordCreation)
        let notificationInfo = CKNotificationInfo()
        notificationInfo.alertBody = "New contact created"
        subscription.notificationInfo = notificationInfo
        publicDatabase.save(subscription) { (_, error) in
            if let error = error {
                NSLog("\(error)")
            }
            completion(error)
        }
    }
}
