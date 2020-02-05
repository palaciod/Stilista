//
//  JobCollectionView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/16/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class JobCollectionView: UIView {
    var userSession: UserSession?
    var navigator: UINavigationController?
    var jobs: [Job]?
    let stilistaApi = StilistaApi()
    let imageStorage = FirebaseStorage()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset.top = 15
        let recycler = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recycler.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        recycler.translatesAutoresizingMaskIntoConstraints = false
        recycler.register(JobCell.self, forCellWithReuseIdentifier: "jobID")
        return recycler
    }()
    private let background: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = #imageLiteral(resourceName: "stilistabackground")
        return background
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(collectionView)
        setUpCollectionView()
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
    
}

extension JobCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.9, height: collectionView.frame.height * 0.6)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jobID", for: indexPath) as! JobCell
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.cornerRadius = 8
        let index = indexPath[1]
        let clientID = jobs?[index].user ?? "404"
        let jobStatus = jobs?[index].status ?? false
        setProfilePicture(clientID: clientID, cell: cell)
        let name  = jobs?[index].name ?? "404"
        setName(name: name, cell: cell)

        let message = jobs?[index].message ?? "404"
        setMessage(message: message, cell: cell)
        
        let appointment = jobs?[index].appointment ?? "404"
        setAppointment(appointment: appointment, cell: cell)
        
        setTarget(button: cell.buttons.acceptButton, index: index)
        deleteButtonTarget(button: cell.buttons.declineButton, index: index)
        
        setCornerRadius(cell: cell)
        if jobStatus {
            cell.buttons.acceptButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            cell.buttons.acceptButton.setTitle("Accepted", for: .normal)
        }
        
        return cell
    }
    private func setName(name: String, cell: JobCell){
        cell.clientNameLabel.text = name
    }
    private func setMessage(message: String, cell: JobCell){
        cell.messageLabel.text = message
    }
    private func setProfilePicture(clientID: String, cell: JobCell){
        let imageView = cell.profilePicture
        imageStorage.downloadImageUrl(userID: clientID, image: imageView)
    }
    private func setAppointment(appointment: String, cell: JobCell){
        cell.appointmentLabel.text = appointment
    }
    
    private func setTarget(button: UIButton, index: Int){
        button.tag = index
        button.addTarget(self, action: #selector(acceptJob), for: .touchUpInside)
    }
    @objc private func acceptJob(sender: UIButton){
        let jobID = jobs?[sender.tag]._id ?? "404"
        stilistaApi.updateJobStatus(jobID: jobID, status: true)
        sender.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        sender.setTitle("Accepted", for: .normal)
    }
    
    private func deleteButtonTarget(button: UIButton, index: Int){
        button.tag = index
        button.addTarget(self, action: #selector(deleteIdea), for: .touchUpInside)
    }
    
    @objc private func deleteIdea(sender: UIButton){
        let index = sender.tag
        let indexPath: [IndexPath] = [[0,index]]
        let jobID = jobs?[index]._id ?? "404"
        stilistaApi.deleteJob(jobID: jobID)
        jobs?.remove(at: index)
        collectionView.deleteItems(at: indexPath)
        updateButtonTags()
    }
    private func updateButtonTags(){
        var count = jobs!.count - 1
        for cell in collectionView.visibleCells{
            let jobCell = cell as! JobCell
            jobCell.buttons.declineButton.tag = count
            count -= 1
        }
    }
    
    private func setCornerRadius(cell: JobCell){
        // Below are the width geometries we manipulated for the profile picture of each cell.
        let cornerRadius = (self.frame.width/2) * 0.9 * 0.98 * 0.15
        cell.profilePicture.layer.cornerRadius = cornerRadius
    }
    
    
}
