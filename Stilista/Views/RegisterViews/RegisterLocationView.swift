//
//  RegisterLocationView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/20/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class RegisterLocationView: UIView {
    
    let back: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        button.setTitle(" Register Location ↑ ", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .center
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
     let mapView: MapView = {
        let map = MapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(back)
        setUpBackButton()
        self.addSubview(mapView)
        setUpMap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setUpBackButton(){
        back.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        back.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        back.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        back.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06).isActive = true
        // Add target
        back.addTarget(self, action: #selector(showMap), for: UIControl.Event.touchUpInside)
    }
    private func setUpMap(){
        mapView.topAnchor.constraint(equalTo: back.bottomAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    @objc private func showMap(){
        print("To Register")
        UIView.animate(withDuration: 0.75, animations: {
            
            let y = self.center.y
            print("This is my y: \(y)")
            self.transform = CGAffineTransform(translationX: 0, y: y)
        })
    }

}
