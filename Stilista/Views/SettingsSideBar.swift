//
//  SettingsSideBar.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/17/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class SettingsSideBar: UIView {
    var userGroup: String?
    let title: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Settings ▷", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        return button
    }()
    private let options: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return view
    }()
    let appointmentsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Appointments", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        return button
    }()
    let reviewsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Reviews", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        return button
    }()
    let changeProfilePictureButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Profile Picture", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        return button
    }()
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.addSubview(title)
        setUpTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpTitle(){
        title.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        title.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    
    func setUpOptions(){
        self.addSubview(options)
        options.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        options.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        options.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        options.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        // Adding settings options
        options.addSubview(changeProfilePictureButton)
        options.addSubview(logoutButton)
        setUpChangePicture()
        setUpButton()
    }
    
    
    private func setUpChangePicture(){
        changeProfilePictureButton.topAnchor.constraint(equalTo: options.topAnchor).isActive = true
        changeProfilePictureButton.leadingAnchor.constraint(equalTo: options.leadingAnchor, constant: 10).isActive = true
        changeProfilePictureButton.trailingAnchor.constraint(equalTo: options.trailingAnchor).isActive = true
        changeProfilePictureButton.heightAnchor.constraint(equalTo: options.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    private func setUpButton(){
        logoutButton.topAnchor.constraint(equalTo: changeProfilePictureButton.bottomAnchor).isActive = true
        logoutButton.leadingAnchor.constraint(equalTo: options.leadingAnchor, constant: 10).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: options.trailingAnchor).isActive = true
        logoutButton.heightAnchor.constraint(equalTo: options.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    
    func setUpUserOptions(){
        self.addSubview(options)
        options.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        options.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        options.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        options.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        // Adding settings options
        options.addSubview(appointmentsButton)
        options.addSubview(reviewsButton)
        options.addSubview(changeProfilePictureButton)
        options.addSubview(logoutButton)
        setUpAppointments()
        setUpReviews()
        setUpUserChangePicture()
        setUpUserLogout()
    }
    
    private func setUpAppointments(){
        appointmentsButton.topAnchor.constraint(equalTo: options.topAnchor).isActive = true
        appointmentsButton.leadingAnchor.constraint(equalTo: options.leadingAnchor, constant: 10).isActive = true
        appointmentsButton.trailingAnchor.constraint(equalTo: options.trailingAnchor).isActive = true
        appointmentsButton.heightAnchor.constraint(equalTo: options.heightAnchor, multiplier: 0.06).isActive = true
    }
    private func setUpReviews(){
        reviewsButton.topAnchor.constraint(equalTo: appointmentsButton.bottomAnchor).isActive = true
        reviewsButton.leadingAnchor.constraint(equalTo: options.leadingAnchor, constant: 10).isActive = true
        reviewsButton.trailingAnchor.constraint(equalTo: options.trailingAnchor).isActive = true
        reviewsButton.heightAnchor.constraint(equalTo: options.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    private func setUpUserChangePicture(){
        changeProfilePictureButton.topAnchor.constraint(equalTo: reviewsButton.bottomAnchor).isActive = true
        changeProfilePictureButton.leadingAnchor.constraint(equalTo: options.leadingAnchor, constant: 10).isActive = true
        changeProfilePictureButton.trailingAnchor.constraint(equalTo: options.trailingAnchor).isActive = true
        changeProfilePictureButton.heightAnchor.constraint(equalTo: options.heightAnchor, multiplier: 0.06).isActive = true
    }
    private func setUpUserLogout(){
        logoutButton.topAnchor.constraint(equalTo: changeProfilePictureButton.bottomAnchor).isActive = true
        logoutButton.leadingAnchor.constraint(equalTo: options.leadingAnchor, constant: 10).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: options.trailingAnchor).isActive = true
        logoutButton.heightAnchor.constraint(equalTo: options.heightAnchor, multiplier: 0.06).isActive = true
    }
}



