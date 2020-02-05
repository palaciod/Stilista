//
//  TopProfileView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/18/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class TopProfileView: UIView {
    var stylistID: String?
    let profilePicture: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6235294118, blue: 0.8705882353, alpha: 1)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
    }()
    
    let ratingView: RatingView = {
        let view = RatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    let rateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rate Stylist", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        button.layer.cornerRadius = 8
        button.alpha = 0
        return button
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rating: "
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(profilePicture)
        self.addSubview(ratingView)
        self.addSubview(ratingLabel)
        self.addSubview(rateButton)
        setUpProfilePicture()
        setUpRatingView()
        setUpRatingLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpProfilePicture(){
        profilePicture.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        profilePicture.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        profilePicture.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        profilePicture.widthAnchor.constraint(equalTo: profilePicture.heightAnchor).isActive = true
    }
    private func setUpRatingView(){
        ratingView.leadingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        ratingView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        ratingView.topAnchor.constraint(equalTo: profilePicture.topAnchor).isActive = true
        ratingView.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    private func setUpRatingLabel(){
        ratingLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        ratingLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        ratingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    func setUpRatingButton(){
        rateButton.alpha = 1
        rateButton.topAnchor.constraint(equalTo: ratingView.bottomAnchor).isActive = true
        rateButton.leadingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        rateButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        rateButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        rateButton.addTarget(self, action: #selector(toRateViewController), for: .touchUpInside)
    }
    
    @objc private func toRateViewController(){
        let main = self.window?.rootViewController?.children[0] as! MainViewController
        let navigator = main.navigationController
        let rateController = RateStylistViewController()
        rateController.stylistID = stylistID
        navigator?.pushViewController(rateController, animated: true)
    }
    
}
