//
//  ContactViewController.swift
//  ContactList
//
//  Created by Andrew Ervin Gierke on 2/24/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    //MARK: - Properties
    
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
        
        
        
        
        guard let name = nameTextField.text,
            let number = numberTextField.text,
            let email = emailTextField.text else { return }
        let contact = Contact(name: name, number: number, email: email)
        ContactController.shared.create(contact: contact)
        let _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK: - Helper Methods 
    
    func updateViews() {
        guard let contact = contact else { return }
        
        print("have contact: \(contact.name)")
        nameTextField.text = contact.name
        numberTextField.text = contact.number
        emailTextField.text = contact.email
    }
    
}
