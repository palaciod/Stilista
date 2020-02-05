//
//  StylistCell.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/18/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class StylistCell: UICollectionViewCell {
    var index: Int?
    var stylistID: String?
     let profilePicture: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
    }()
    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name?"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let email: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email?"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let ratingView: RatingView = {
        let ratingView = RatingView()
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.firstStar.textColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1)
        ratingView.secondStar.textColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1)
        ratingView.thirdStar.textColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1)
        ratingView.fourthStar.textColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1)
        ratingView.fifthStar.textColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1)
        return ratingView
    }()
    let openProfileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let stilistaApi = StilistaApi()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(profilePicture)
        self.addSubview(name)
        
        self.addSubview(email)
        self.addSubview(openProfileButton)
        setUpProfilePicture()
        setUpNameLabel()
        setUpEmail()
        setUpCellButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpProfilePicture(){
        profilePicture.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        profilePicture.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        profilePicture.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        profilePicture.widthAnchor.constraint(equalTo: profilePicture.heightAnchor).isActive = true
        
       
    }
    private func setUpNameLabel(){
        name.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        name.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: profilePicture.trailingAnchor, constant: 10).isActive = true
        name.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setUpEmail(){
        email.topAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        email.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        email.leadingAnchor.constraint(equalTo: profilePicture.trailingAnchor, constant: 10).isActive = true
        email.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    private func setUpCellButton(){
        openProfileButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        openProfileButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        openProfileButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        openProfileButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    
    
}
