//
//  NavBar.swift
//  My Journal
//
//  Created by Daniel Palacio on 1/5/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//
import UIKit

class NavBar: UIView {
    public var screen: String = "main"
    /**
     A button that will take the user to the settings view controller
     */
    public let rightButton: UIButton = {
        let button = UIButton(type: .system)
        // button.setTitle("⚙️", for: .normal)
        button.setTitle("New Post", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        return button
    }()
    /**
     A button that will take the user to the profile view controller
     */
    public let leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        return button
    }()
    public let centerButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        return button
    }()
    
    /**
     The initializer for this class. Inherits from UIView.
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        self.addSubview(centerButton)
        setUpSettingsButton()
        setUpProfileButton()
        setUpCenterButton()
    }
    /**
     Satisfying the compiler to assure it that if this class were to have any subclasses, they would inherit or implement this same initializer. There is doubt on this point, because of the rule that if a subclass has a designated initializer of its own, no initializers from the superclass are inherited. Thus it is possible for a superclass to have an initializer and the subclass not to have it.
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /**
     Sets up the Profile button to the left side of the parent view with a fourth of the width.
     */
    private func setUpProfileButton(){
        leftButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        leftButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        leftButton.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        leftButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        
    }
    /**
     Sets up the Settings button to the right side of the parent view with a fourth of the width.
     */
    private func setUpSettingsButton(){
        rightButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        rightButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        rightButton.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        rightButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
    }
    
    private func setUpCenterButton(){
        centerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        centerButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        centerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        centerButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
    }
    
    
    
    
    
    
}


