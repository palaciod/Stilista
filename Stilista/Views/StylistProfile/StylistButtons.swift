//
//  StylistButtons.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/20/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class StylistButtons: UIView {
    
    let showLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Location", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    private let firstSpace: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let secondSpace: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(firstSpace)
        setUpFirstSpace()
        self.addSubview(showLocationButton)
        setUpLocationButton()
        self.addSubview(secondSpace)
        setUpSecondSpace()
        self.addSubview(addPhotoButton)
        setUpAddPhotoButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpFirstSpace(){
        firstSpace.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        firstSpace.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        firstSpace.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        firstSpace.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
    }
    private func setUpLocationButton(){
        showLocationButton.topAnchor.constraint(equalTo: firstSpace.bottomAnchor).isActive = true
        showLocationButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        showLocationButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        showLocationButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setUpSecondSpace(){
        secondSpace.topAnchor.constraint(equalTo: showLocationButton.bottomAnchor).isActive = true
        secondSpace.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        secondSpace.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        secondSpace.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setUpAddPhotoButton(){
        addPhotoButton.topAnchor.constraint(equalTo: secondSpace.bottomAnchor).isActive = true
        addPhotoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        addPhotoButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        addPhotoButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
    }
    

}
