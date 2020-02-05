//
//  PictureViewController.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/24/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {
    var userGroup: String?
    var userID: String?
    let navBar: NavBar = {
        let navBar = NavBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.leftButton.setTitle(" ◀︎ Back", for: .normal)
        navBar.rightButton.setTitle("", for: .normal)
        return navBar
    }()
    let picture: UIImageView = {
        let picture = UIImageView()
        picture.translatesAutoresizingMaskIntoConstraints = false
        
        picture.contentMode = UIView.ContentMode.scaleAspectFill
        picture.clipsToBounds = true
        return picture
    }()
    
    private let blankSpace: UIView = {
        let space = UIView()
        space.translatesAutoresizingMaskIntoConstraints = false
        return space
    }()
    private let pictureSetting: UIView = {
        let space = UIView()
        space.translatesAutoresizingMaskIntoConstraints = false
        space.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return space
    }()
    private let topButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.7294117647, green: 0.1843137255, blue: 0.05098039216, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let stilistaApi = StilistaApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        setUser()
        view.addSubview(navBar)
        view.addSubview(picture)
        setUpNavBar()
        setUpPicture()
        setUpPictureSetting()
    }
    
    deinit {
        print("Releasing RequestAppoitmentViewController from memory.")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUser(){
        if userGroup == "user"{
        }else{
            navBar.rightButton.setTitle("•••", for: .normal)
            
        }
    }
    
    private func setUpNavBar(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        // Adding targets to the left and right buttons
        navBar.leftButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
        navBar.rightButton.addTarget(self, action: #selector(toSettings), for: .touchUpInside)
    }
    private func setUpPicture(){
        picture.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        picture.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        picture.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        picture.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
    }
    
    @objc private func popBack(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setUpPictureSetting(){
        view.addSubview(pictureSetting)
        pictureSetting.leadingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pictureSetting.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pictureSetting.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        pictureSetting.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        let cornerRadius = (view.frame.width * 0.8) / 10
        pictureSetting.layer.cornerRadius = cornerRadius
        print("This is my corner: \(cornerRadius)")
        setUpTopButton()
        setUpDeleteButton()
    }
    private func setUpTopButton(){
        pictureSetting.addSubview(topButton)
        topButton.topAnchor.constraint(equalTo: pictureSetting.topAnchor).isActive = true
        topButton.leadingAnchor.constraint(equalTo: pictureSetting.leadingAnchor).isActive = true
        topButton.trailingAnchor.constraint(equalTo: pictureSetting.trailingAnchor).isActive = true
        topButton.heightAnchor.constraint(equalTo: picture.heightAnchor, multiplier: 0.1).isActive = true
        
        topButton.addTarget(self, action: #selector(hideSettings), for: .touchUpInside)
    }
    private func setUpDeleteButton(){
        pictureSetting.addSubview(deleteButton)
        deleteButton.centerXAnchor.constraint(equalTo: pictureSetting.centerXAnchor).isActive = true
        deleteButton.topAnchor.constraint(equalTo: topButton.bottomAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalTo: pictureSetting.widthAnchor, multiplier: 0.8).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: pictureSetting.heightAnchor, multiplier: 0.4).isActive = true
    }
    @objc private func toSettings(){
        print("To settings nla")
        UIView.animate(withDuration: 0.55, animations: {
            let x = (self.view.frame.maxX * 0.9)
            print("This is my x: \(x)")
            self.pictureSetting.transform = CGAffineTransform(translationX: -x, y: 0)
        })
    }
    @objc private func hideSettings(){
        print("To settings nla")
        UIView.animate(withDuration: 0.55, animations: {
            let x = (self.view.frame.maxX * 0.9)
            print("This is my x: \(x)")
            self.pictureSetting.transform = CGAffineTransform(translationX: x, y: 0)
        })
    }
    @objc private func delete(){
        print("delete")
    }
    
    
    

}
