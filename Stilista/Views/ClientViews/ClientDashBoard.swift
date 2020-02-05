//
//  ClientDashBoard.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/22/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class ClientDashBoard: UIView {
    
    var filterDistanceValue = 5
    var clientID: String?
    let title: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("◁ Profile", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .right
        
        return button
    }()
    
    private let blankSpace: UIView = {
        let space = UIView()
        space.translatesAutoresizingMaskIntoConstraints = false
        return space
    }()
    
    let profilePicture: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6235294118, blue: 0.8705882353, alpha: 1)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
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
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    private let maxDistanceOneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Maximum Distance: "
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    private let maxDistanceValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " 5 mi"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    let updateFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update Distance Filter", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6235294118, blue: 0.8705882353, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let stilistaApi = StilistaApi()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.addSubview(title)
        self.addSubview(blankSpace)
        self.addSubview(profilePicture)
        self.addSubview(clientInfoFields)
        self.addSubview(updateButton)
        self.addSubview(slider)
        self.addSubview(maxDistanceOneLabel)
        self.addSubview(maxDistanceValue)
        setUpTitle()
        setUpBlankSpace()
        setUpProfilePicture()
        setUpClientFields()
        setUpUpdateButton()
        setUpSlider()
        setUpFirstMaxDistanceLabel()
        setUpMaxDistanceValue()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTitle(){
        title.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        title.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06).isActive = true
    }
    private func setUpBlankSpace(){
        blankSpace.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        blankSpace.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        blankSpace.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        blankSpace.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.03).isActive = true
    }
    
    private func setUpProfilePicture(){
        profilePicture.topAnchor.constraint(equalTo: blankSpace.bottomAnchor).isActive = true
        profilePicture.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profilePicture.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        profilePicture.heightAnchor.constraint(equalTo: profilePicture.widthAnchor).isActive = true
    }
    
    private func setUpClientFields(){
        clientInfoFields.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 50).isActive = true
        clientInfoFields.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        clientInfoFields.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        clientInfoFields.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    
    private func setUpUpdateButton(){
        updateButton.topAnchor.constraint(equalTo: clientInfoFields.bottomAnchor, constant: 50).isActive = true
        updateButton.leadingAnchor.constraint(equalTo: clientInfoFields.leadingAnchor).isActive = true
        updateButton.trailingAnchor.constraint(equalTo: clientInfoFields.trailingAnchor).isActive = true
        updateButton.heightAnchor.constraint(equalTo: clientInfoFields.heightAnchor, multiplier: 1/3).isActive = true
        updateButton.addTarget(self, action: #selector(updateProfile), for: .touchUpInside)
    }
    
    @objc func updateProfile(){
        let name = clientInfoFields.nameTextField.text!
        let email = clientInfoFields.emailTextField.text!
        stilistaApi.updateClient(clientID: clientID ?? "404", name: name, email: email.lowercased())
        
    }
    
    private func setUpSlider(){
        slider.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: 50).isActive = true
        slider.leadingAnchor.constraint(equalTo: updateButton.leadingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: updateButton.trailingAnchor).isActive = true
        slider.heightAnchor.constraint(equalTo: updateButton.heightAnchor, multiplier: 1/2).isActive = true
        slider.addTarget(self, action: #selector(prinThis), for: .valueChanged)
        slider.setValue(5/20, animated: true)
    }
    
    @objc private func prinThis(){
        // slider.value will never exceed the range of int, so it is safe to parse it as is.
        print((Int(slider.value * 20)))
        let maxDistance = Int(slider.value * 20)
        maxDistanceValue.text = "\(maxDistance.description) mi"
        filterDistanceValue = maxDistance
    }
    
    private func setUpFirstMaxDistanceLabel(){
        maxDistanceOneLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10).isActive = true
        maxDistanceOneLabel.leadingAnchor.constraint(equalTo: slider.leadingAnchor).isActive = true
        maxDistanceOneLabel.widthAnchor.constraint(equalTo: slider.widthAnchor, multiplier: 1/2).isActive = true
        maxDistanceOneLabel.heightAnchor.constraint(equalTo: slider.heightAnchor).isActive = true
    }
    private func setUpMaxDistanceValue(){
        maxDistanceValue.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10).isActive = true
        maxDistanceValue.trailingAnchor.constraint(equalTo: slider.trailingAnchor).isActive = true
        maxDistanceValue.widthAnchor.constraint(equalTo: slider.widthAnchor, multiplier: 1/5).isActive = true
        maxDistanceValue.heightAnchor.constraint(equalTo: slider.heightAnchor).isActive = true
    }
    
    

}
