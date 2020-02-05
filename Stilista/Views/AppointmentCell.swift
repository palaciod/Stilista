//
//  AppointmentCell.swift
//  Stilista
//
//  Created by Daniel Palacio on 2/4/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class AppointmentCell: UICollectionViewCell {
    let profilePicture: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        //image.layer.cornerRadius = 25
        return image
    }()
    let appointmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "appointment?"
        label.font = UIFont(name: "HelveticaNeue-bold", size: 25.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let declineButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cancel"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        label.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.2196078431, blue: 0.2862745098, alpha: 1)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    let rightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let leftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let leftBlock: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let bottomBlock: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let topBlock: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(appointmentLabel)
        self.addSubview(rightView)
        self.addSubview(leftView)
        setUpAppointmentLabel()
        setUpRightView()
        setUpLeftView()
        setUpLeftBlock()
        setUpBottomBlock()
        setUpTopBlock()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpAppointmentLabel(){
        appointmentLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        appointmentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        appointmentLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45).isActive = true
        appointmentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    private func setUpRightView(){
        rightView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        rightView.leadingAnchor.constraint(equalTo: appointmentLabel.trailingAnchor).isActive = true
        rightView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        rightView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        setUpDeclineButton()
    }
    private func setUpDeclineButton(){
        rightView.addSubview(declineButton)
        declineButton.centerXAnchor.constraint(equalTo: rightView.centerXAnchor).isActive = true
        declineButton.centerYAnchor.constraint(equalTo: rightView.centerYAnchor).isActive = true
        declineButton.widthAnchor.constraint(equalTo: rightView.widthAnchor, multiplier: 0.7).isActive = true
        declineButton.heightAnchor.constraint(equalTo: declineButton.widthAnchor).isActive = true
    }
    
    private func setUpLeftView(){
        leftView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        leftView.trailingAnchor.constraint(equalTo: appointmentLabel.leadingAnchor).isActive = true
        leftView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        setUpProfilePicture()
    }
    private func setUpProfilePicture(){
        leftView.addSubview(profilePicture)
        profilePicture.centerXAnchor.constraint(equalTo: leftView.centerXAnchor).isActive = true
        profilePicture.centerYAnchor.constraint(equalTo: leftView.centerYAnchor).isActive = true
        profilePicture.widthAnchor.constraint(equalTo: leftView.widthAnchor, multiplier: 0.9).isActive = true
        profilePicture.heightAnchor.constraint(equalTo: profilePicture.widthAnchor).isActive = true
        profilePicture.layer.cornerRadius = 44
    }
    
    private func setUpLeftBlock(){
        self.addSubview(leftBlock)
        leftBlock.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftBlock.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        leftBlock.trailingAnchor.constraint(equalTo: declineButton.leadingAnchor).isActive = true
        leftBlock.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    private func setUpBottomBlock(){
        self.addSubview(bottomBlock)
        bottomBlock.topAnchor.constraint(equalTo: declineButton.bottomAnchor).isActive = true
        bottomBlock.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomBlock.leadingAnchor.constraint(equalTo: leftBlock.trailingAnchor).isActive = true
        bottomBlock.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setUpTopBlock(){
        self.addSubview(topBlock)
        topBlock.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topBlock.leadingAnchor.constraint(equalTo: leftBlock.trailingAnchor).isActive = true
        topBlock.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        topBlock.bottomAnchor.constraint(equalTo: declineButton.topAnchor).isActive = true
    }
    
}
