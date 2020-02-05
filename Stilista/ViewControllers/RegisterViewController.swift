//
//  RegisterViewController.swift
//  VidJot
//
//  Created by Daniel Palacio on 1/12/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    private let segmentedControl: UISegmentedControl = {
        var segControl = UISegmentedControl(items: ["Client","Stylist"])
        segControl.selectedSegmentIndex = 0
        segControl.tintColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        segControl.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        segControl.translatesAutoresizingMaskIntoConstraints = false
        segControl.layer.masksToBounds = true
        segControl.clipsToBounds = true
        return segControl
    }()
    private let background: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = #imageLiteral(resourceName: "stilistabackground")
        background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return background
    }()
    private let navBar: NavBar = {
        let navbar = NavBar()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        navbar.leftButton.setTitle("Back", for: .normal)
        navbar.rightButton.setTitle("", for: .normal)
        return navbar
    }()
    
    private let regisetInputView: RegisterInputView = {
        let inputFields = RegisterInputView()
        inputFields.translatesAutoresizingMaskIntoConstraints = false
        return inputFields
    }()
    private let blankSpace = UIView()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        button.setTitle("Finish Registration", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    private let mapView: RegisterLocationView = {
        let map = RegisterLocationView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    private let imageUploadView: ProfileUploadView = {
        let imageUploadView = ProfileUploadView()
        imageUploadView.translatesAutoresizingMaskIntoConstraints = false
        return imageUploadView
    }()
    
    private let stilistaApi = StilistaApi()
    private let firebaseStoreage = FirebaseStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(navBar)
        view.addSubview(background)
        view.addSubview(regisetInputView)
        view.addSubview(segmentedControl)
        view.addSubview(registerButton)
        view.addSubview(mapView)
        mapView.mapView.checkLocationServices()
        view.addSubview(imageUploadView)
        setUpNavBar()
        setUpBackground()
        createBlankSpace(blankSpace: blankSpace, y: regisetInputView.bottomAnchor)
        setUpRegisterView()
        setUpSegementedController()
        setUpRegisterButton()
        setUpMap()
        setUpProfileUploadView()
        //view.addSubview(activityIndicator)
       
    }
    
    deinit {
        print("RegisterViewController has been released from memory.")
    }
    /**
     An overrided method that removes the systems keyboard when any non textfield is touched.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUpNavBar(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        // Adding targets to the left and right buttons
        navBar.leftButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        navBar.rightButton.setTitle("Next", for: .normal)
        navBar.rightButton.addTarget(self, action: #selector(toNextStep), for: .touchUpInside)
        registerButton.alpha = 0
        
    }
    private func setUpBackground(){
        background.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    private func setUpRegisterView(){
        regisetInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        regisetInputView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        regisetInputView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        regisetInputView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    private func setUpSegementedController(){
        segmentedControl.bottomAnchor.constraint(equalTo: regisetInputView.topAnchor, constant: -10).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: regisetInputView.widthAnchor, multiplier: 1/2).isActive = true
        segmentedControl.heightAnchor.constraint(equalTo: regisetInputView.emailTextField.heightAnchor, multiplier: 1/2).isActive = true
        segmentedControl.addTarget(self, action: #selector(segmentedControlTarget), for: .valueChanged)
        
    }
    
    @objc private func segmentedControlTarget(){
        print(segmentedControl.selectedSegmentIndex)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            print("Client Register")
            registerButton.alpha = 0
            imageUploadView.registerButton.removeTarget(self, action: #selector(registerStylist), for: .touchUpInside)
            imageUploadView.registerButton.addTarget(self, action: #selector(registerClient), for: .touchUpInside)
        }else{
            print("Stylist Register")
            registerButton.removeTarget(self, action: #selector(registerClient), for: .touchUpInside)
            registerButton.addTarget(self, action: #selector(showMap), for: .touchUpInside)
            registerButton.setTitle("Register Location", for: .normal)
            //navBar.rightButton.addTarget(self, action: #selector(toNextStep), for: .touchUpInside)
            //navBar.rightButton.setTitle("Next", for: .normal)
            registerButton.alpha = 1
            imageUploadView.registerButton.removeTarget(self, action: #selector(registerClient), for: .touchUpInside)
            imageUploadView.registerButton.addTarget(self, action: #selector(registerStylist), for: .touchUpInside)
        }
    }
    
    
    private func createBlankSpace(blankSpace: UIView, y: NSLayoutYAxisAnchor){
        blankSpace.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blankSpace)
        blankSpace.topAnchor.constraint(equalTo: y).isActive = true
        blankSpace.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blankSpace.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        blankSpace.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
    }
    
    private func setUpRegisterButton(){
        registerButton.topAnchor.constraint(equalTo: blankSpace.bottomAnchor).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: regisetInputView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/20).isActive = true
        
        // Adding targets
        registerButton.addTarget(self, action: #selector(registerClient), for: .touchUpInside)
    }
    
    private func setUpMap(){
        mapView.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        //
        //mapView.mapView.checkLocationServices()
    }
    private func setUpProfileUploadView(){
        imageUploadView.registerViewController = self
        imageUploadView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageUploadView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageUploadView.leadingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageUploadView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageUploadView.registerButton.addTarget(self, action: #selector(registerClient), for: .touchUpInside)
    }
    
    
    
    @objc private func back(){
        mapView.mapView.map.delegate = nil
        mapView.mapView.locationManager?.delegate = nil
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func showMap(){
        print("To Map")
        UIView.animate(withDuration: 0.75, animations: {
            let top = self.view.safeAreaInsets.top
            let y = self.view.center.y * 2 - top
            self.mapView.transform = CGAffineTransform(translationX: 0, y: -y)
            
        })
        
        let width = (mapView.mapView.frame.width/2) * 0.05
        mapView.mapView.centerCircle.layer.cornerRadius = width
    }
    @objc private func toNextStep(){
        print("To profile upload")
        let cornerRadius = imageUploadView.profilePicture.layer.frame.width / 2
        imageUploadView.profilePicture.layer.cornerRadius = cornerRadius
        imageUploadView.alpha = 1
        print(cornerRadius)
        UIView.animate(withDuration: 0.55, animations: {
            let x = self.view.center.x * 2
            print("This is my x: \(x)")
            self.imageUploadView.transform = CGAffineTransform(translationX: -x, y: 0)
        })
    }
    
    private func checkFields() -> Bool {
        let nameString = regisetInputView.nameTextField.text ?? ""
        let emailString = regisetInputView.emailTextField.text ?? ""
        let passwordString = regisetInputView.passwordTextField.text ?? ""
        let secondPasswordString = regisetInputView.secondPasswordTextField.text ?? ""
        if nameString.isEmpty || emailString.isEmpty || passwordString.isEmpty || secondPasswordString.isEmpty {
            return false
        }
        return true
    }
    
    private func doPasswordsMatch() -> Bool {
        let passwordString = regisetInputView.passwordTextField.text ?? ""
        let secondPasswordString = regisetInputView.secondPasswordTextField.text ?? ""
        if passwordString == secondPasswordString {
            return true
        }
        return false
    }
    
    private func checkLocationStatus() -> Bool{
        let long = mapView.mapView.long
        let lat = mapView.mapView.lat
        if long == nil || lat == nil {
            return false
        }
        return true
    }
    
    @objc private func registerStylist(){
        let nameString = regisetInputView.nameTextField.text ?? ""
        let emailString = regisetInputView.emailTextField.text ?? ""
        let passwordString = regisetInputView.passwordTextField.text ?? ""
        let secondPasswordString = regisetInputView.secondPasswordTextField.text ?? ""
        let long = mapView.mapView.long ?? 0
        let lat = mapView.mapView.lat ?? 0
        let imageUploadStatus = imageUploadView.uploadStatus
        let image = imageUploadView.profilePicture.imageView?.image
        if checkFields() && doPasswordsMatch() && checkLocationStatus() && imageUploadStatus{
            print("Success")
            mapView.mapView.map.delegate = nil
            mapView.mapView.locationManager!.delegate = nil
            stilistaApi.registerStylist(name: nameString, email: emailString.lowercased(), password: passwordString, password2: secondPasswordString, long: long, lat: lat, image: image!, registerViewController: self)
            imageUploadView.registerButton.setTitle("Loading new profile...", for: .normal)
            imageUploadView.activityIndicator.startAnimating()
            imageUploadView.registerButton.isEnabled = false
        }else{
            print("failed")
        }
        // Adding alerts
        if !checkFields(){
            let alert = UIAlertController(title: "Incomplete Form", message: "Please fill in all required fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }
        if !doPasswordsMatch(){
            let alert = UIAlertController(title: "Passwords Do Not Match", message: "Make sure that your passwords match.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }
        if !imageUploadStatus {
            let alert = UIAlertController(title: "Profile Picture Not Detected", message: "Please upload a profile picture.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }
        if !checkLocationStatus(){
            let alert = UIAlertController(title: "Your Location Was Not Recorded", message: "Please register your location to show to future clients.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }
        
    }
    
    @objc private func registerClient(){
        let nameString = regisetInputView.nameTextField.text ?? ""
        let emailString = regisetInputView.emailTextField.text ?? ""
        let passwordString = regisetInputView.passwordTextField.text ?? ""
        let secondPasswordString = regisetInputView.secondPasswordTextField.text ?? ""
        let imageUploadStatus = imageUploadView.uploadStatus
        let image = imageUploadView.profilePicture.imageView?.image // there will be a default image in the profilePicture view
        if checkFields() && doPasswordsMatch() && imageUploadStatus{
            mapView.mapView.map.delegate = nil
            //mapView.mapView.locationManager!.delegate = nil
            print("Success")
            stilistaApi.registerClient(name: nameString, email: emailString.lowercased(), password: passwordString, password2: secondPasswordString, registerViewController: self, image: image!)
            imageUploadView.registerButton.setTitle("Loading new profile...", for: .normal)
            imageUploadView.activityIndicator.startAnimating()
            imageUploadView.registerButton.isEnabled = false
        }else{
            print("Fill in the required fields.")
        }
        // Adding alerts
        if !checkFields(){
            let alert = UIAlertController(title: "Incomplete Form", message: "Please fill in all required fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }
        if !doPasswordsMatch(){
            let alert = UIAlertController(title: "Passwords Do Not Match", message: "Make sure that your passwords match.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }
        if !imageUploadStatus {
            let alert = UIAlertController(title: "Profile Picture Not Detected", message: "Please upload a profile picture.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }
        
    }
    
    
}
