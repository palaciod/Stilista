//
//  AppointmentsViewController.swift
//  Stilista
//
//  Created by Daniel Palacio on 2/3/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class AppointmentsViewController: UIViewController {
    var appointments : [Job]?
    let model = RatingModel()
    let stilistaApi = StilistaApi()
    let imageStorage = FirebaseStorage()
    let navBar: NavBar = {
        let navBar = NavBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.leftButton.setTitle(" ◀︎ Back", for: .normal)
        navBar.rightButton.setTitle("", for: .normal)
        return navBar
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset.top = 15
        let recycler = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recycler.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        recycler.translatesAutoresizingMaskIntoConstraints = false
        recycler.register(AppointmentCell.self, forCellWithReuseIdentifier: "appointmentID")
        return recycler
    }()
    
    override func viewDidLoad() {
        stilistaApi.getAppointments(clientID: model.clientID ?? "404", appointmentsViewController: self)
        super.viewDidLoad()
        view.addSubview(navBar)
        setUpNavBar()
        setUpCollectionView()
        // Do any additional setup after loading the view.
    }
    deinit {
        print("Releasing AppointmentViewController...")
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

extension AppointmentsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.95, height: collectionView.frame.height * 0.2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let size = appointments?.count ?? 0
        return size
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "appointmentID", for: indexPath) as! AppointmentCell
        let index = indexPath[1]
        let appointment = appointments?[index].appointment ?? "404 Not Found"
        let stylistID = appointments?[index].stylist ?? "404 Not Found"
        cell.appointmentLabel.text = appointment
        circulePicture(picture: cell.profilePicture)
        setImage(userID: stylistID, imageView: cell.profilePicture)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath[1]
        let id = appointments?[index]._id ?? "404 Not Found"
        appointments?.remove(at: index)
        let indexPath1: [IndexPath] = [[0,index]]
        collectionView.deleteItems(at: indexPath1)
        stilistaApi.deleteJob(jobID: id)
    }
    
    private func setImage(userID: String, imageView: UIImageView){
        imageStorage.downloadImageUrl(userID: userID, image: imageView)
    }
    
    private func circulePicture(picture: UIImageView){
        let cornerRadius = (view.frame.width * 0.23466666666666666)/2
        picture.layer.cornerRadius = cornerRadius
    }
    
}



