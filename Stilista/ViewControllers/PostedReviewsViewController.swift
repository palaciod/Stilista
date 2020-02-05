//
//  PostedReviewsViewController.swift
//  Stilista
//
//  Created by Daniel Palacio on 2/3/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class PostedReviewsViewController: UIViewController {
    var ratings: [Rating]?
    let stilistaApi = StilistaApi()
    let model = RatingModel()
    let navBar: NavBar = {
        let navBar = NavBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.leftButton.setTitle(" ◀︎ Back", for: .normal)
        navBar.rightButton.setTitle("", for: .normal)
        return navBar
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navBar)
        setUpNavBar()
        stilistaApi.getClientReviews(clientID: model.clientID ?? "404", reviewsViewController: self)
        setUpCollectionView()
    }
    deinit {
        print("Releasing PostReviewController from memory...")
    }
    
    private func setUpNavBar(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        // Adding targets to the left and right buttons
        navBar.leftButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
    }
    
    private func setUpCollectionView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.view.addSubview(self.collectionView)
            self.collectionView.topAnchor.constraint(equalTo: self.navBar.bottomAnchor).isActive = true
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
    
    
    @objc private func popBack(){
        navigationController?.popViewController(animated: true)
    }
    

}


extension PostedReviewsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.95, height: collectionView.frame.height * 0.2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let size = ratings?.count ?? 0
        return size
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewID", for: indexPath) as! ReviewCell
        cell.layer.cornerRadius = view.frame.width/15
        let index = indexPath[1]
        cell.setUpDeleteButton()
        cell.setDeleteButtonBlock()
        cell.setUpSecondBlock()
        let clientID = ratings?[index].client ?? "404"
        let review = ratings?[index].review ?? "404"
        let name = ratings?[index].name ?? "404"
        let value = ratings?[index].value ?? 0
        let stylistID = ratings?[index].stylist ?? "404"
        print("This is my clientID: \(clientID), this is mt review: \(review), this is my name: \(name)")
        setProfilePicture(stylistID: stylistID, cell: cell)
        setReview(review: review, cell: cell)
        setName(name: name, cell: cell)
        setValue(value: value, cell: cell)
        setCornerRadius(cell: cell)
        
        // Adding target
        print(index)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath[1]
        let reviewID = ratings?[index]._id ?? "404 Not Found"
        let stylistID = ratings?[index].stylist ?? "404 Not Found"
        let indexPath1: [IndexPath] = [[0,index]]
        ratings?.remove(at: index)
        collectionView.deleteItems(at: indexPath1)
        stilistaApi.deleteReview(reviewID: reviewID)
        self.model.stylistID = stylistID
        self.model.getStylistReviews()
        updateStylistValue(stylistID: stylistID)
    }
    
    private func updateStylistValue(stylistID: String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            // Updating value
            guard let reviewsSize = self.model.ratings?.count else {return}
            if reviewsSize != 0{
                let addedValue = self.model.addAllRatings()
                let average = addedValue/Double.init(reviewsSize)
                print("This is my average: \(average)")
                
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.stilistaApi.updateRating(stylistID: stylistID, rating: 0)
                }
            }
            
        }
    }
    

    private func setProfilePicture(stylistID: String, cell: ReviewCell){
        let imageView = cell.profilePicture
        imageStorage.downloadImageUrl(userID: stylistID, image: imageView)
    }

    private func setReview(review: String, cell: ReviewCell){
        cell.reviewLabel.text = review
    }
    private func setName(name: String, cell: ReviewCell){
        cell.nameLabel.text = name
    }

    private func setCornerRadius(cell: ReviewCell){
        // Below are the width geometries we manipulated for the profile picture of each cell.
        let cornerRadius = (view.frame.height/2) * 0.08
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
