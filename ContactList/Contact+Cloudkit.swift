//
//  Contact+CloudKit.swift
//  ContactList
//
//  Created by Andrew Ervin Gierke on 2/24/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import Foundation
import CloudKit

extension Contact {
    
    init?(cloudKitRecord: CKRecord) {
        guard let name = cloudKitRecord[Keys.nameKey] as? String,
            let number = cloudKitRecord[Keys.numberKey] as? String,
            let email = cloudKitRecord[Keys.emailKey] as? String,
            cloudKitRecord.recordType == Keys.contactRecordType else { return nil }
        self.init(name: name, number: number, email: email)
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Keys.contactRecordType)
        record[Keys.nameKey] = name  as CKRecordValue?
        record[Keys.numberKey] = number as CKRecordValue?
        record[Keys.emailKey] = email as CKRecordValue?
        return record
    }
}
