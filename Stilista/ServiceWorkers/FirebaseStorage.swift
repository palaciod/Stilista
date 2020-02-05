//
//  FirebaseStorage.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/20/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import Foundation
import FirebaseStorage
import Kingfisher
struct FirebaseStorage {
    static let storeage = Storage.storage()
    
    func uploadProfilePicture(userID: String,image: UIImage){
        let jpegData = image.jpegData(compressionQuality: 1.0) ?? Data.init()
        let imageReference = FirebaseStorage.storeage.reference().child("profilePictures").child(userID)
        imageReference.putData(jpegData, metadata: nil) { (metaData, error) in
            if let error = error {
                print("Failed to upload image <--------fbs--------->")
                print(error.localizedDescription)
            }else{
                imageReference.downloadURL(completion: { (url, err) in
                    if let error = error {
                        print("failed to download url<--------fbs--------->")
                        print(error.localizedDescription)
                    }else{
                        guard url != nil else{
                            print("URL failed<---------fbs-------->")
                            return
                        }
                        print("Successful write to Firebase Storage")
                    }
                })
            }
        }
    }
    
    public func downloadImageUrl(userID: String, image: UIImageView){
        let imageStorage = FirebaseStorage.storeage.reference().child("profilePictures").child(userID)
        imageStorage.downloadURL { (url, error) in
            if let error = error {
                print("Failed to download image")
                print(error.localizedDescription)
            }else{
                print("Successful Download")
                image.kf.setImage(with: url)
            }
        }
    }
    
    public func downloadImageUrlForButton(userID: String, button: UIButton){
        let imageStorage = FirebaseStorage.storeage.reference().child("profilePictures").child(userID)
        imageStorage.downloadURL { (url, error) in
            if let error = error {
                print("Failed to download image")
                print(error.localizedDescription)
            }else{
                print("Successful Download")
                button.kf.setImage(with: url, for: .normal)
            }
        }
    }
    
   
    
  
    
    
    
    
    
}
