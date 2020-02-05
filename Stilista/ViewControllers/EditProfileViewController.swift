//
//  EditProfileViewController.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/30/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    var stylistID: String?
    var email: String?
    var name: String?
    let navBar: NavBar = {
        let navBar = NavBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.leftButton.setTitle(" ◀︎ Back", for: .normal)
        navBar.rightButton.setTitle("", for: .normal)
        return navBar
    }()
    let clientInfoFields: UpdateClientInfoView = {
        let fields = UpdateClientInfoView()
        fields.translatesAutoresizingMaskIntoConstraints = false
        return fields
    }()
    let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update Profile", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6235294118, blue: 0.8705882353, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let stilistaApi = StilistaApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.addSubview(navBar)
        view.addSubview(clientInfoFields)
        view.addSubview(updateButton)
        setUpNavBar()
        setUpClientFields()
        setUpUpdateButton()
    }
    
    deinit {
        print("EditProfileViewController has been released from memory.")
    }
    /**
     An overrided method that removes the systems keyboard when any non textfield is touched.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUpNavBar(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        // Adding targets to the left and right buttons
        navBar.leftButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
    }
    
    @objc private func popBack(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setUpClientFields(){
        clientInfoFields.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        clientInfoFields.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        clientInfoFields.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        clientInfoFields.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        // Setting texts
        clientInfoFields.emailTextField.text = email!
        clientInfoFields.nameTextField.text = name!
    }
    
    private func setUpUpdateButton(){
        updateButton.topAnchor.constraint(equalTo: clientInfoFields.bottomAnchor, constant: 50).isActive = true
        updateButton.leadingAnchor.constraint(equalTo: clientInfoFields.leadingAnchor).isActive = true
        updateButton.trailingAnchor.constraint(equalTo: clientInfoFields.trailingAnchor).isActive = true
        updateButton.heightAnchor.constraint(equalTo: clientInfoFields.heightAnchor, multiplier: 1/3).isActive = true
        updateButton.addTarget(self, action: #selector(updateNameEmail), for: .touchUpInside)
    }
    
    @objc private func updateNameEmail(){
        print("Updating...")
        stilistaApi.updateStylist(stylistID: stylistID!, name: clientInfoFields.nameTextField.text!, email: clientInfoFields.emailTextField.text!)
        let main = navigationController?.children[0] as! MainViewController
        main.stylistSideBar.nameLabel.text = clientInfoFields.nameTextField.text
        navigationController?.popViewController(animated: true)
    }

    

}
