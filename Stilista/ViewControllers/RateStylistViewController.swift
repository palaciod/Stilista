//
//  RateStylistViewController.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/30/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class RateStylistViewController: UIViewController {
    let stilistaApi = StilistaApi()
    var rateValue: Double?
    var stylistID: String?
    let navBar: NavBar = {
        let navBar = NavBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.leftButton.setTitle(" ◀︎ Back", for: .normal)
        navBar.rightButton.setTitle("", for: .normal)
        return navBar
    }()
    let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    private let maxDistanceOneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rate your stylist: "
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    private let maxDistanceValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " 1"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    let rateModel = RatingModel()
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue", size: 20.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        textView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return textView
    }()
    let postRating: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        button.setTitle("Post", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        rateModel.stylistID = stylistID!
        rateModel.getStylistDetails()
        rateModel.getStylistReviews()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.addSubview(navBar)
        view.addSubview(messageTextView)
        view.addSubview(slider)
        view.addSubview(maxDistanceOneLabel)
        view.addSubview(maxDistanceValue)
        view.addSubview(postRating)
        setUpNavBar()
        setUpMessageTextView()
        setUpSlider()
        setUpFirstMaxDistanceLabel()
        setUpMaxDistanceValue()
        setUpPostRating()
    }
    deinit {
        print("Releasing rate controller from memory")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUpNavBar(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        // Adding targets to the left and right buttons
        navBar.leftButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
    }
    private func setUpMessageTextView(){
        messageTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageTextView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 10).isActive = true
        messageTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        messageTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
    }
    private func setUpSlider(){
        slider.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 20).isActive = true
        slider.leadingAnchor.constraint(equalTo: messageTextView.leadingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: messageTextView.trailingAnchor).isActive = true
        slider.heightAnchor.constraint(equalTo: messageTextView.heightAnchor, multiplier: 1/4).isActive = true
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        slider.setValue(0, animated: true)
        slider.minimumValue = 1/5
        rateValue = 0
    }
    
    private func setUpFirstMaxDistanceLabel(){
        maxDistanceOneLabel.topAnchor.constraint(equalTo: slider.bottomAnchor).isActive = true
        maxDistanceOneLabel.leadingAnchor.constraint(equalTo: slider.leadingAnchor).isActive = true
        maxDistanceOneLabel.widthAnchor.constraint(equalTo: slider.widthAnchor, multiplier: 1/2).isActive = true
        maxDistanceOneLabel.heightAnchor.constraint(equalTo: slider.heightAnchor).isActive = true
    }
    private func setUpMaxDistanceValue(){
        maxDistanceValue.topAnchor.constraint(equalTo: slider.bottomAnchor).isActive = true
        maxDistanceValue.trailingAnchor.constraint(equalTo: slider.trailingAnchor).isActive = true
        maxDistanceValue.widthAnchor.constraint(equalTo: slider.widthAnchor, multiplier: 1/5).isActive = true
        maxDistanceValue.heightAnchor.constraint(equalTo: slider.heightAnchor).isActive = true
    }
    
    private func setUpPostRating(){
        postRating.topAnchor.constraint(equalTo: maxDistanceOneLabel.bottomAnchor).isActive = true
        postRating.leadingAnchor.constraint(equalTo: slider.leadingAnchor).isActive = true
        postRating.trailingAnchor.constraint(equalTo: slider.trailingAnchor).isActive = true
        postRating.heightAnchor.constraint(equalTo: slider.heightAnchor).isActive = true
        postRating.addTarget(self, action: #selector(post), for: .touchUpInside)
    }
    @objc private func changeValue(){
        let value = Int(slider.value * 5)
        maxDistanceValue.text = "\(value.description)"
        print(slider.value)
    }
    
    @objc private func popBack(){
        navigationController?.popViewController(animated: true)
    }
    @objc private func post(){
        rateValue = Double.init(slider.value*5)
        guard let clientID = rateModel.clientID else {return}
        guard let name = rateModel.clientDetails?.name else {return}
        let review = messageTextView.text
        if rateValue == 0.0 {
            print("<-------ewncfjc fjcan fkfn jlad---------\(Int.init(rateValue!))>")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.stilistaApi.postRating(clientID: clientID, name: name, stylistID: self.stylistID!, value: 0, review: review!, controller: self)
            }
        }else{
            let addedReviewValues = rateModel.addAllRatings()
            guard let reviewsSize = rateModel.ratings?.count else {return}
            let finalAddeedValue = rateValue! + addedReviewValues
            let finalValue = finalAddeedValue/Double.init(reviewsSize+1)
            stilistaApi.updateRating(stylistID: stylistID!, rating: Int.init(finalValue))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.stilistaApi.postRating(clientID: clientID, name: name, stylistID: self.stylistID!, value: Int.init(self.rateValue!), review: review!, controller: self)
            }
        }
    }
    

}
