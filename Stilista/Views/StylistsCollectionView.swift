//
//  StylistsCollectionView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/18/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class StylistsCollectionView: UIView {
    
    var userSession: UserSession?
    var stylists: [Stylist]?
    private let imageStorage = FirebaseStorage()
    let stilistaApi = StilistaApi()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset.top = 15
        let recycler = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recycler.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        recycler.translatesAutoresizingMaskIntoConstraints = false
        recycler.register(StylistCell.self, forCellWithReuseIdentifier: "stylistID")
        return recycler
    }()
    private let background: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = #imageLiteral(resourceName: "stilistabackground")
        return background
    }()
    private let stylistProfile: StylistDashBoardView = {
        let profile = StylistDashBoardView()
        profile.translatesAutoresizingMaskIntoConstraints = false
        profile.title.contentHorizontalAlignment = .center
        profile.title.setTitle("▽ Stylist", for: .normal)
        return profile
    }()

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(collectionView)
        self.addSubview(stylistProfile)
        setUpCollectionView()
        setUpStylistProfile()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpCollectionView(){
        collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        collectionView.backgroundView = background
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setUpStylistProfile(){
        stylistProfile.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stylistProfile.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stylistProfile.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stylistProfile.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        // Adding targets
        stylistProfile.title.addTarget(self, action: #selector(hideStylistProfile), for: .touchUpInside)
    }
    
}

extension StylistsCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.9, height: collectionView.frame.height * 0.2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stylists?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stylistID", for: indexPath) as! StylistCell
        cell.layer.cornerRadius = 8
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let index = indexPath[1]
        
        let cornerRadius = (cell.frame.height - 30)/2
        cell.profilePicture.layer.cornerRadius = cornerRadius
        let name  = stylists?[index].name ?? "404"
        let stylistValue = stylists?[index].rating ?? 0
        cell.ratingView.stylistValue = stylistValue
        setName(name: name, cell: cell)
        print(cell.frame.height)
        print(cornerRadius)
        let email = stylists?[index].email ?? "404"
        setEmail(email: email, cell: cell)
        let userID = stylists?[index]._id ?? "404"
        cell.openProfileButton.tag = index
        setImage(userID: userID, imageView: cell.profilePicture)
        cell.openProfileButton.addTarget(self, action: #selector(showStylistProfile), for: .touchUpInside)
        
        
        return cell
    }
    
    private func setName(name: String, cell: StylistCell){
        cell.name.text = name
    }
    private func setEmail(email: String, cell: StylistCell){
        cell.email.text = email
    }
    
    private func setImage(userID: String, imageView: UIImageView){
        imageStorage.downloadImageUrl(userID: userID, image: imageView)
    }
    private func setStylistProfile(index: Int){
        stylistProfile.topView.setUpRatingButton()
        let stylistID = stylists?[index]._id ?? "404"
        
        stylistProfile.nameLabel.text = stylists?[index].name
        setRatings(stylistID: stylistID, collection: stylistProfile.bottomView.mapAndPhotos.reviewGallery)
        stylistProfile.bottomView.mapAndPhotos.mapView.long = stylists?[index].location.coordinates[0]
        stylistProfile.bottomView.mapAndPhotos.mapView.lat = stylists?[index].location.coordinates[1]
        stylistProfile.bottomView.mapAndPhotos.mapView.setLocation()
        stylistProfile.topView.stylistID = stylistID
        let profileImage = stylistProfile.topView.profilePicture
        imageStorage.downloadImageUrl(userID: stylistID, image: profileImage)
        let stylistValue = stylists?[index].rating ?? 0
        stylistProfile.topView.ratingView.stylistValue = stylistValue
        stylistProfile.topView.ratingView.setValue()
    }
    @objc private func showStylistProfile(sender: UIButton){
        let x = self.center.x
        let index = sender.tag
        print("Opening \(stylists![index].name)'s profile with an x value of \(x)")
        setStylistProfile(index: index)
        setRequestAppointmentButton(index: index)
        
        UIView.animate(withDuration: 0.75, animations: {
            //let top = self.layoutMargins.top * 50
            let y = self.collectionView.center.y * 2
            print("This is my y: \(y)")
            self.stylistProfile.transform = CGAffineTransform(translationX: 0, y: -y)
            
        })
       
        let cornerRadius = stylistProfile.topView.profilePicture.frame.width/2
        stylistProfile.topView.profilePicture.layer.cornerRadius = cornerRadius
    }
    @objc private func hideStylistProfile(){
        UIView.animate(withDuration: 0.75, animations: {
            //let top = self.layoutMargins.top * 50
            let y = self.collectionView.center.y * 2
            print("This is my y going back down: \(y)")
            self.stylistProfile.transform = CGAffineTransform(translationX: 0, y: y)
            self.stylistProfile.bottomView.mapAndPhotos.reviewGallery.ratings = nil
            self.stylistProfile.bottomView.mapAndPhotos.reviewGallery.collectionView.reloadData()
        })
    }
    
    private func setRequestAppointmentButton(index: Int){
        stylistProfile.bottomView.buttons.addPhotoButton.tag = index
        stylistProfile.bottomView.buttons.addPhotoButton.setTitle("Request Appointment", for: .normal)
        stylistProfile.bottomView.buttons.addPhotoButton.addTarget(self, action: #selector(requestAppointmentViewController), for: .touchUpInside)
    }
    
    @objc func requestAppointmentViewController(sender: UIButton){
        print("To request view controller")
        let main = self.window?.rootViewController?.children[0] as! MainViewController
        let navigator = main.navigationController
        let requestViewController = RequestAppointmentViewController()
        requestViewController.index = sender.tag
        navigator?.pushViewController(requestViewController, animated: true)
    }
    private func setRatings(stylistID: String, collection: ReviewCollectionView){
        stilistaApi.getStylistReviews(stylistID: stylistID, collection: collection)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            collection.collectionView.reloadData()
        }
    }
    
    
}
