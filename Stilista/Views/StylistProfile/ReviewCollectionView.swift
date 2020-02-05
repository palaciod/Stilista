//
//  ReviewCollectionView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/30/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class ReviewCollectionView: UIView {
    var ratings: [Rating]?
    let imageStorage = FirebaseStorage()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset.top = 15
        let recycler = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recycler.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        recycler.translatesAutoresizingMaskIntoConstraints = false
        recycler.register(ReviewCell.self, forCellWithReuseIdentifier: "reviewID")
        return recycler
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(collectionView)
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setUpCollectionView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            self.collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
}

extension ReviewCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.95, height: collectionView.frame.height * 0.4)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let size = ratings?.count ?? 0
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewID", for: indexPath) as! ReviewCell
        cell.layer.cornerRadius = self.frame.width/15
        let index = indexPath[1]
        let clientID = ratings?[index].client ?? "404"
        let review = ratings?[index].review ?? "404"
        let name = ratings?[index].name ?? "404"
        let value = ratings?[index].value ?? 0
        setProfilePicture(clientID: clientID, cell: cell)
        setReview(review: review, cell: cell)
        setName(name: name, cell: cell)
        setValue(value: value, cell: cell)
        setCornerRadius(cell: cell)
        return cell
    }
    
    private func setProfilePicture(clientID: String, cell: ReviewCell){
        let imageView = cell.profilePicture
        imageStorage.downloadImageUrl(userID: clientID, image: imageView)
    }
    
    private func setReview(review: String, cell: ReviewCell){
        cell.reviewLabel.text = review
    }
    private func setName(name: String, cell: ReviewCell){
        cell.nameLabel.text = name
    }
    
    private func setCornerRadius(cell: ReviewCell){
        // Below are the width geometries we manipulated for the profile picture of each cell.
        let cornerRadius = (self.frame.height/2) * 0.18
        print("This is my height for this frame: \(cornerRadius)")
        cell.profilePicture.layer.cornerRadius = cornerRadius
    }
    
    private func setValue(value: Int, cell: ReviewCell){
        switch value{
        case 0:
            cell.valueLabel.text = "404"
            break
        case 1 :
            cell.valueLabel.text = "★☆☆☆☆"
            break
        case 2:
            cell.valueLabel.text = "★★☆☆☆"
            break
        case 3:
            cell.valueLabel.text = "★★★☆☆"
            break
        case 4:
            cell.valueLabel.text = "★★★★☆"
            break
        case 5:
            cell.valueLabel.text = "★★★★★"
        default:
            break
        }
    }
    
}
