//
//  AcceptDeclineView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/17/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class AcceptDeclineView: UIView {
    
    let declineButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.2196078431, blue: 0.2862745098, alpha: 1)
        button.setTitle("Decline", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        return button
    }()
    let acceptButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        button.setTitle("Accept", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(declineButton)
        self.addSubview(acceptButton)
        setUpDeleteButton()
        setUpEditButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpDeleteButton(){
        declineButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        declineButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        declineButton.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    private func setUpEditButton(){
        acceptButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        acceptButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        acceptButton.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        acceptButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        
    }
    
    

}
