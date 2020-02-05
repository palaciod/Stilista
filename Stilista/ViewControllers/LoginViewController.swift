//
//  LoginViewController.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/15/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit


func print(_ items: Any...) {
    #if DEBUG
        Swift.print(items[0])
    #endif
}

class LoginViewController: UIViewController {
    let stilistaLogo: UIImageView = {
        var logo = UIImageView()
        logo.image = #imageLiteral(resourceName: "stilistaLogo02-1")
        logo.translatesAutoresizingMaskIntoConstraints = false
        //logo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    private let logoSpace: UIView = {
        let space = UIView()
        space.translatesAutoresizingMaskIntoConstraints = false
        return space
    }()
    private let background: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = #imageLiteral(resourceName: "stilistabackground")
        return background
    }()
    
    let segmentedControl: UISegmentedControl = {
        var segControl = UISegmentedControl(items: ["Client","Stylist"])
        segControl.selectedSegmentIndex = 0
        if #available(iOS 13.0, *) {
            segControl.selectedSegmentTintColor = #colorLiteral(red: 0.7294117647, green: 0.1843137255, blue: 0.05098039216, alpha: 1)
        } else {
            // Fallback on earlier versions
        }
        segControl.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        segControl.translatesAutoresizingMaskIntoConstraints = false
        segControl.layer.masksToBounds = true
        segControl.clipsToBounds = true
        return segControl
    }()
    
    private let loginTextView: LoginInputView = {
        let textFields = LoginInputView()
        textFields.translatesAutoresizingMaskIntoConstraints = false
        return textFields
    }()
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    private let blankSpace: UIView = {
        let space = UIView()
        space.translatesAutoresizingMaskIntoConstraints = false
        return space
    }()
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register here", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.7294117647, green: 0.1843137255, blue: 0.05098039216, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    private let stilistaApi = StilistaApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkSignInStatus()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(background)
        view.addSubview(segmentedControl)
        view.addSubview(loginTextView)
        view.addSubview(loginButton)
        view.addSubview(blankSpace)
        view.addSubview(registerButton)
        setUpBackground()
        setUpLoginView()
        setUpLoginButton()
        setUpBlankSpace()
        setUpRegisterButton()
        setUpSegmentedController()
        setUpLogoSpace()
        setUpLogo()
        
    }
    
    deinit {
        print("LoginViewController has been released from memory.")
    }
    
    /**
     An overrided method that removes the systems keyboard when any non textfield is touched.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func checkSignInStatus(){
        stilistaApi.signInStatus(loginViewController: self)
    }
    
    private func setUpLogo(){
        logoSpace.addSubview(stilistaLogo)
        stilistaLogo.centerXAnchor.constraint(equalTo: logoSpace.centerXAnchor).isActive = true
        stilistaLogo.centerYAnchor.constraint(equalTo: logoSpace.centerYAnchor).isActive = true
        stilistaLogo.widthAnchor.constraint(equalTo: logoSpace.widthAnchor, multiplier: 0.35).isActive = true
        stilistaLogo.heightAnchor.constraint(equalTo: logoSpace.heightAnchor, multiplier: 0.05).isActive = true
    }
    private func setUpLogoSpace(){
        view.addSubview(logoSpace)
        logoSpace.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor).isActive = true
        logoSpace.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoSpace.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        logoSpace.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    private func setUpBackground(){
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    
    private func setUpLoginView(){
        loginTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        loginTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        loginTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
    }
    
    private func setUpSegmentedController(){
        segmentedControl.bottomAnchor.constraint(equalTo: loginTextView.topAnchor, constant: -20).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: loginTextView.widthAnchor, multiplier: 1/2).isActive = true
        segmentedControl.heightAnchor.constraint(equalTo: loginButton.heightAnchor, multiplier: 1/2).isActive = true
        segmentedControl.addTarget(self, action: #selector(segmentedControlTarget), for: .valueChanged)
        
    }
    
    private func setUpLoginButton(){
        loginButton.topAnchor.constraint(equalTo: loginTextView.bottomAnchor, constant: 30).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: loginTextView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/20).isActive = true
        // Adding target
        loginButton.addTarget(self, action: #selector(clientLogin), for: .touchUpInside)
    }
    private func setUpBlankSpace(){
        blankSpace.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blankSpace.topAnchor.constraint(equalTo: loginButton.bottomAnchor).isActive = true
        blankSpace.widthAnchor.constraint(equalTo: loginButton.widthAnchor).isActive = true
        blankSpace.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/30).isActive = true
    }
    private func setUpRegisterButton(){
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: blankSpace.bottomAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor).isActive = true
        // Adding target
        registerButton.addTarget(self, action: #selector(toRegister), for: .touchUpInside)
    }
    
    @objc private func segmentedControlTarget(){
        print(segmentedControl.selectedSegmentIndex)
        if segmentedControl.selectedSegmentIndex == 0 {
            print("Client login")
            loginButton.removeTarget(self, action: #selector(stylistLogin), for: .touchUpInside)
            loginButton.addTarget(self, action: #selector(clientLogin), for: .touchUpInside)
        }else{
            print("Stylist Login")
            loginButton.removeTarget(self, action: #selector(clientLogin), for: .touchUpInside)
            loginButton.addTarget(self, action: #selector(stylistLogin), for: .touchUpInside)
        }
    }
    
    @objc private func stylistLogin(){
        let emailString = loginTextView.loginTextField.text ?? ""
        print(emailString)
        let passwordString = loginTextView.passwordTextField.text ?? ""
        print(passwordString)
        if emailString.isEmpty || passwordString.isEmpty {
            print("Fill in the requiered fields")
            let alert = UIAlertController(title: "Incomplete Form", message: "Please fill in all required fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }else{
            stilistaApi.stylistLogin(email: emailString.lowercased(), password: passwordString, loginViewController: self)
        }
    }
    @objc private func clientLogin(){
        let emailString = loginTextView.loginTextField.text ?? ""
        print(emailString)
        let passwordString = loginTextView.passwordTextField.text ?? ""
        print(passwordString)
        if emailString.isEmpty || passwordString.isEmpty {
            print("Fill in the requiered fields")
            let alert = UIAlertController(title: "Incomplete Form", message: "Please fill in all required fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }else{
            stilistaApi.clientLogin(email: emailString.lowercased(), password: passwordString, loginViewController: self)
        }
    }
    @objc private func toRegister(){
        let register = RegisterViewController()
        navigationController?.pushViewController(register, animated: true)
    }
    

}
