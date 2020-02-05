//
//  JobCell.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/16/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class JobCell: UICollectionViewCell {
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
    let topView: UIView = {
        let top = UIView()
        top.translatesAutoresizingMaskIntoConstraints = false
        return top
    }()
    let clientNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name?"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    private let firstLine: UIView = {
        let black = UIView()
        black.translatesAutoresizingMaskIntoConstraints = false
        black.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return black
    }()
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Message?"
        label.font = UIFont(name: "HelveticaNeue", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    private let secondLine: UIView = {
        let black = UIView()
        black.translatesAutoresizingMaskIntoConstraints = false
        black.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return black
    }()
    let appointmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "appointment?"
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let buttons: AcceptDeclineView = {
        let buttons = AcceptDeclineView()
        buttons.translatesAutoresizingMaskIntoConstraints  = false
        return buttons
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        //self.addSubview(clientNameLabel)
        self.addSubview(topView)
        self.addSubview(profilePicture)
        self.addSubview(clientNameLabel)
        self.addSubview(firstLine)
        self.addSubview(messageLabel)
        self.addSubview(secondLine)
        self.addSubview(appointmentLabel)
        self.addSubview(buttons)
        setUpTopView()
        setUpProfilePicture()
        setUpClientName()
        setUpFirtLine()
        setUpMessage()
        setUpSecondLine()
        setUpAppointmentLabel()
        setUpButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpTopView(){
        topView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        topView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        topView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.98).isActive = true
        topView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
    }
    private func setUpProfilePicture(){
        profilePicture.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10).isActive = true
        profilePicture.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor).isActive = true
        profilePicture.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        profilePicture.heightAnchor.constraint(equalTo: profilePicture.widthAnchor).isActive = true
    }
    
    private func setUpClientName(){
        clientNameLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        clientNameLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        clientNameLabel.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.5).isActive = true
        clientNameLabel.heightAnchor.constraint(equalTo: topView.heightAnchor).isActive = true
    }
    private func setUpFirtLine(){
        firstLine.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        firstLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        firstLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        firstLine.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.009).isActive = true
    }
    private func setUpMessage(){
        messageLabel.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95).isActive = true
        messageLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.333).isActive = true
    }
    private func setUpSecondLine(){
        secondLine.topAnchor.constraint(equalTo: messageLabel.bottomAnchor).isActive = true
        secondLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        secondLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        secondLine.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.009).isActive = true
    }
    private func setUpAppointmentLabel(){
        appointmentLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor).isActive = true
        appointmentLabel.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor).isActive = true
        appointmentLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        appointmentLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
    }
    private func setUpButtons(){
        buttons.topAnchor.constraint(equalTo: appointmentLabel.bottomAnchor).isActive = true
        buttons.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttons.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        buttons.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
}
