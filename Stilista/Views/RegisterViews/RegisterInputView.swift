//
//  RegisterInputView.swift
//  VidJot
//
//  Created by Daniel Palacio on 1/13/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class RegisterInputView: UIView {
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = " Name"
        textField.attributedPlaceholder = NSAttributedString(string: "Name",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return textField
    }()
    private let firstBlankSpace = UIView()
    let emailTextField: UITextField = {
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
    private let secondBlankSpace = UIView()
    
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
    private let thirdBlankSpace = UIView()
    
    let secondPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = " Retype Password"
        textField.attributedPlaceholder = NSAttributedString(string: "Retype Password",
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
        self.addSubview(nameTextField)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(secondPasswordTextField)
        setUpNameTextField()
        setUpEmailTextField()
        setUpPasswordTextField()
        setUpSecondPasswordTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createBlankSpace(blankSpace: UIView, y: NSLayoutYAxisAnchor){
        blankSpace.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(blankSpace)
        blankSpace.topAnchor.constraint(equalTo: y).isActive = true
        blankSpace.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        blankSpace.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        blankSpace.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/7).isActive = true
    }
    
    private func setUpNameTextField(){
        nameTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/7).isActive = true
        createBlankSpace(blankSpace: firstBlankSpace, y: nameTextField.bottomAnchor)
    }
    
    private func setUpEmailTextField(){
        emailTextField.topAnchor.constraint(equalTo: firstBlankSpace.bottomAnchor).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/7).isActive = true
        createBlankSpace(blankSpace: secondBlankSpace, y: emailTextField.bottomAnchor)
    }
    private func setUpPasswordTextField(){
        passwordTextField.topAnchor.constraint(equalTo: secondBlankSpace.bottomAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/7).isActive = true
        createBlankSpace(blankSpace: thirdBlankSpace, y: passwordTextField.bottomAnchor)
    }
    private func setUpSecondPasswordTextField(){
        secondPasswordTextField.topAnchor.constraint(equalTo: thirdBlankSpace.bottomAnchor).isActive = true
        secondPasswordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        secondPasswordTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        secondPasswordTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/7).isActive = true
    }
    

    
}
