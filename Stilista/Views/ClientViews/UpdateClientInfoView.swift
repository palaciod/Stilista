//
//  UpdateClientInfoView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/24/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class UpdateClientInfoView: UIView {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name: "
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = " Name"
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return textField
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email: "
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = " Name"
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return textField
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(nameLabel)
        self.addSubview(nameTextField)
        self.addSubview(emailLabel)
        self.addSubview(emailTextField)
        setUpNameLabel()
        setUpNameTextField()
        setUpEmailLabel()
        setUpEmailTextField()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNameLabel(){
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
    }
    private func setUpNameTextField(){
        nameTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    private func setUpEmailLabel(){
        emailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        emailLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        emailLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
    }
    private func setUpEmailTextField(){
        emailTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
    }
    
}
