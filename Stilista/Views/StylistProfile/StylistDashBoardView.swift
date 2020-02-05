//
//  StylistDashBoardView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/18/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class StylistDashBoardView: UIView {
    let title: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("◁ Profile", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .right
        
        return button
    }()

    let topView: TopProfileView = {
        let view = TopProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name?"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    
    
    var bottomView: StylistProfileBottomView = {
        let view = StylistProfileBottomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.addSubview(title)
        self.addSubview(topView)
        self.addSubview(nameLabel)
        self.addSubview(bottomView)
        setUpTitle()
        setUpTopView()
        setUpNameLabel()
        setUpBottomView()
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
    
    private func setUpTopView(){
        topView.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    private func setUpNameLabel(){
        nameLabel.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.profilePicture.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    private func setUpBottomView(){
        bottomView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
