//
//  MapAndPhotoGalleryView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/19/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class MapAndPhotoGalleryView: UIView {
    
    let mapView: MapView = {
        let map = MapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let reviewGallery: ReviewCollectionView = {
        let gallery = ReviewCollectionView()
        gallery.translatesAutoresizingMaskIntoConstraints = false
        return gallery
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(mapView)
        self.addSubview(reviewGallery)
        setUpMap()
        setUpReviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpMap(){
        mapView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setUpReviews(){
        reviewGallery.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        reviewGallery.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        reviewGallery.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        reviewGallery.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    
    
    

}
