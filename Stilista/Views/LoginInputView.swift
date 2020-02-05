//
//  LoginInputView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/15/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class LoginInputView: UIView {
    
    let loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = " Email"
        textField.attributedPlaceholder = NSAttributedString(string: "Email",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = " Password"
        textField.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return textField
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(loginTextField)
        self.addSubview(passwordTextField)
        setUpLogin()
        setUpPassword()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLogin(){
        loginTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        loginTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        loginTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    private func setUpPassword(){
        passwordTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
    }
    
}

