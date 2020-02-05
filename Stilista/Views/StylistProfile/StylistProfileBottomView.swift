//
//  StylistProfileBottomView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/19/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class StylistProfileBottomView: UIView {
    private var mainViewController: MainViewController?
    
    private let imageStorage = FirebaseStorage()
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
    
    let buttons: StylistButtons = {
        let buttons = StylistButtons()
        buttons.translatesAutoresizingMaskIntoConstraints = false
        buttons.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return buttons
    }()
    let mapAndPhotos: MapAndPhotoGalleryView = {
        let view = MapAndPhotoGalleryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(mapAndPhotos)
        self.addSubview(buttons)
        setUpMapAndPhotos()
        setUpButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpButtons(){
        buttons.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttons.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        buttons.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        buttons.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        buttons.showLocationButton.addTarget(self, action: #selector(showLocation), for: .touchUpInside)
        
    }
    private func setUpLocationButton(){
        showLocationButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        showLocationButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        showLocationButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        showLocationButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06).isActive = true
    }
    
    
    private func setUpMapAndPhotos(){
        mapAndPhotos.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mapAndPhotos.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mapAndPhotos.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mapAndPhotos.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
   
    
    @objc private func showLocation(){
        print("Show location")
        UIView.animate(withDuration: 0.55, animations: {
            let y = self.buttons.center.y * 2
            print("This is my y: \(y)")
            self.mapAndPhotos.transform = CGAffineTransform(translationX: 0, y: y)
        })
        buttons.showLocationButton.removeTarget(self, action: #selector(showLocation), for: .touchUpInside)
        buttons.showLocationButton.addTarget(self, action: #selector(hideLocation), for: .touchUpInside)
        buttons.showLocationButton.setTitle("Hide Location", for: .normal)
    }
    @objc private func hideLocation(){
        print("Hide location")
        
        UIView.animate(withDuration: 0.55, animations: {
            self.mapAndPhotos.transform = CGAffineTransform(translationX: 0, y: 0)
        })
        buttons.showLocationButton.removeTarget(self, action: #selector(hideLocation), for: .touchUpInside)
        buttons.showLocationButton.addTarget(self, action: #selector(showLocation), for: .touchUpInside)
        buttons.showLocationButton.setTitle("Show Location", for: .normal)
    }
    
   
    
}


