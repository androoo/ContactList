//
//  Keys.swift
//  ContactList
//
//  Created by Andrew Ervin Gierke on 2/24/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import Foundation

struct Keys {
    
    //MARK: - UITableViewCell Reuse Identifiers
    
    static let contactCellReuseIdentifier = "contactCell"
    
    //MARK: - Segue Identifiers 
    
    static let contactDetailSegue = "toContactDetail"
    
    //MARK: - CloudKit Keys
    
    static let contactRecordType = "Contact"
    static let nameKey = "name"
    static let numberKey = "number"
    static let emailKey = "email"
    
    //MARK: - Notification Center Names
    
    static let DidRefreshNotificaiton = Notification.Name("DidRefreshNotification")
    
}
