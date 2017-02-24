//
//  ContactViewController.swift
//  ContactList
//
//  Created by Andrew Ervin Gierke on 2/24/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import UIKit
import CloudKit

class ContactViewController: UIViewController {
    
    //MARK: - Properties
    private let cloudKitManager = CloudKitManager()
    
    var contact: Contact? {
        didSet {
            if !isViewLoaded {
                loadViewIfNeeded()
            }
            updateViews()
        }
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    

    //MARK: - View Life

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let contact = contact else { return }
        title = "\(contact.name)"
    }
    
    //MARK: - UI Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        
        //check if contact has data
        if let contact = self.contact {
            //update the values
            contact.cloudKitRecord.setValue(nameTextField.text, forKeyPath: Keys.nameKey)
            contact.cloudKitRecord.setValue(numberTextField.text, forKeyPath: Keys.numberKey)
            contact.cloudKitRecord.setValue(emailTextField.text, forKeyPath: Keys.emailKey)
            
            let record = contact.cloudKitRecord
            
            //save
            cloudKitManager.save(record) { (error) in
                if let error = error {
                    NSLog(error.localizedDescription)
                    return
                }
            }
            dismiss(animated: true, completion: nil)
            
        } else {
        
        guard let name = nameTextField.text,
            let number = numberTextField.text,
            let email = emailTextField.text else { return }
        let contact = Contact(name: name, number: number, email: email)
        ContactController.shared.create(contact: contact)
        let _ = navigationController?.popViewController(animated: true)
            
        }
    }
    
    //MARK: - Helper Methods 
    
    func updateViews() {
        guard let contact = contact else { return }
        nameTextField.text = contact.name
        numberTextField.text = contact.number
        emailTextField.text = contact.email
    }
}
