//
//  ProfileUploadView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/20/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class ProfileUploadView: UIView {
    weak var registerViewController: RegisterViewController?
    weak var mainViewController: MainViewController?
    var uploadStatus = false
    let back: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("◁ Back", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        
        return button
    }()
    
    private let blankSpace: UIView = {
        let space = UIView()
        space.translatesAutoresizingMaskIntoConstraints = false
        return space
    }()
    
    let profilePicture: UIButton = {
        let image = UIButton()
        image.setImage(#imageLiteral(resourceName: "ProfileIcon-1"), for: .normal)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
    }()
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Upload Your Profile Picture"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Finish", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6235294118, blue: 0.8705882353, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return indicator
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.addSubview(back)
        setUpBackButton()
        self.addSubview(blankSpace)
        setUpBlankSpace()
        self.addSubview(profilePicture)
        setUpProfilePicture()
        self.addSubview(messageLabel)
        setUpLabel()
        self.addSubview(registerButton)
        setUpRegisterButton()
        setUpProfilePicture()
        self.alpha = 0
        setUpIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpBackButton(){
        back.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive =  true
        back.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        back.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        back.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06).isActive = true
        // Adding target
        back.addTarget(self, action: #selector(hideSettings), for: .touchUpInside)
    }
    
    private func setUpBlankSpace(){
        blankSpace.topAnchor.constraint(equalTo: back.bottomAnchor).isActive = true
        blankSpace.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        blankSpace.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        blankSpace.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setUpProfilePicture(){
        profilePicture.topAnchor.constraint(equalTo: blankSpace.bottomAnchor).isActive = true
        profilePicture.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profilePicture.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        profilePicture.heightAnchor.constraint(equalTo: profilePicture.widthAnchor).isActive = true
        profilePicture.addTarget(self, action: #selector(changePicture), for: .touchUpInside)
    }
    
    private func setUpLabel(){
        messageLabel.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 20).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        messageLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setUpRegisterButton(){
        registerButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        registerButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/20).isActive = true
    }
    private func setUpIndicator(){
        self.addSubview(activityIndicator)
        activityIndicator.topAnchor.constraint(equalTo: registerButton.bottomAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: registerButton.centerXAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        activityIndicator.widthAnchor.constraint(equalTo: registerButton.widthAnchor, multiplier: 0.4).isActive = true
        
    }
    
    @objc private func changePicture(){
        showImagePickerController()
    }
    
    @objc private func hideSettings(){
        print("Back")
        print("This is my upload status: \(uploadStatus)")
        UIView.animate(withDuration: 0.55, animations: {
            let x = self.center.x * 2
            print("This is my x: \(x)")
            self.transform = CGAffineTransform(translationX: x, y: 0)
        })
        self.alpha = 0
    }
    
    
    
}

extension ProfileUploadView: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func showImagePickerController(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        if registerViewController != nil {
            registerViewController!.present(imagePickerController, animated: true, completion: nil)
        }else{
            mainViewController!.present(imagePickerController, animated: true, completion: nil)
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profilePicture.setImage(editedImage, for: .normal)
            uploadStatus = true
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profilePicture.setImage(originalImage, for: .normal)
            uploadStatus = true
        }else{
            print("failedß")
        }
        if registerViewController != nil {
            registerViewController!.dismiss(animated: true, completion: nil)
        }else{
            mainViewController!.dismiss(animated: true, completion: nil)
        }
        
        picker.delegate = nil
    }
}
