//
//  ReviewCell.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/30/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let leftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    let pictureView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let profilePicture: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 17
        return image
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Message?"
        label.font = UIFont(name: "HelveticaNeue", size: 15.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name?"
        label.font = UIFont(name: "HelveticaNeue-bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "★★★★★"
        label.font = UIFont(name: "HelveticaNeue-bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        return label
    }()
    
    public let deleteButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Delete"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        label.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.2196078431, blue: 0.2862745098, alpha: 1)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    public let deleteBlock: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    public let secondBlock: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.addSubview(leftView)
        self.addSubview(reviewLabel)
        setUpLeftView()
        setUpReview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLeftView(){
        leftView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        leftView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        leftView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        setUpPictureView()
        setUpName()
        setUpValueLabel()
        
    }

    private func setUpPictureView(){
        leftView.addSubview(pictureView)
        pictureView.topAnchor.constraint(equalTo: leftView.topAnchor).isActive = true
        pictureView.bottomAnchor.constraint(equalTo: leftView.centerYAnchor).isActive = true
        pictureView.centerXAnchor.constraint(equalTo: leftView.centerXAnchor).isActive = true
        pictureView.widthAnchor.constraint(equalTo: leftView.widthAnchor).isActive = true
        setUpProfilePicture()
    }
    private func setUpName(){
        leftView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: pictureView.bottomAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: leftView.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leftView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: leftView.trailingAnchor).isActive = true
    }
    
    public func setUpDeleteButton(){
        nameLabel.alpha = 0
        leftView.addSubview(deleteButton)
        deleteButton.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 10).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: leftView.heightAnchor, multiplier: 1/3).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: leftView.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalTo: leftView.widthAnchor, multiplier: 0.85).isActive = true
    }
    private func setUpProfilePicture(){
        pictureView.addSubview(profilePicture)
        profilePicture.centerXAnchor.constraint(equalTo: pictureView.centerXAnchor).isActive = true
        profilePicture.topAnchor.constraint(equalTo: pictureView.topAnchor, constant: 10).isActive = true
        profilePicture.heightAnchor.constraint(equalTo: pictureView.heightAnchor, multiplier: 0.9).isActive = true
        profilePicture.widthAnchor.constraint(equalTo: profilePicture.heightAnchor).isActive = true
    }
    private func setUpReview(){
        reviewLabel.leadingAnchor.constraint(equalTo: leftView.trailingAnchor).isActive = true
        reviewLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        reviewLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2/3).isActive = true
        reviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    private func setUpValueLabel(){
        self.addSubview(valueLabel)
        valueLabel.topAnchor.constraint(equalTo: reviewLabel.bottomAnchor).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        valueLabel.leadingAnchor.constraint(equalTo: leftView.trailingAnchor).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    public func setDeleteButtonBlock(){
        self.addSubview(deleteBlock)
        deleteBlock.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        deleteBlock.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor).isActive = true
        deleteBlock.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        deleteBlock.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    public func setUpSecondBlock(){
        leftView.addSubview(secondBlock)
        secondBlock.topAnchor.constraint(equalTo: leftView.topAnchor).isActive = true
        secondBlock.bottomAnchor.constraint(equalTo: leftView.centerYAnchor).isActive = true
        secondBlock.centerXAnchor.constraint(equalTo: leftView.centerXAnchor).isActive = true
        secondBlock.widthAnchor.constraint(equalTo: leftView.widthAnchor).isActive = true
    }
}
