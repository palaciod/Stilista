//
//  MainViewController.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/17/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit
import CoreLocation
class MainViewController: UIViewController {
    var userSession: UserSession?
    var jobs: [Job]?
    var userGroup: String?
    var stylists: [Stylist]?
    var stylistDetails: Stylist?
    var clientDetails: Client?
    var distanceFilter = 5
    var locationManager: CLLocationManager?
    var lat: String?
    var long: String?
    var ratings: [Rating]?
    private let navBar: NavBar = {
        let navBar = NavBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        navBar.leftButton.setTitle("Profile", for: .normal)
        navBar.rightButton.setTitle("Settings", for: .normal)
        return navBar
    }()
    private let jobCollectionView: JobCollectionView = {
        let jobs = JobCollectionView()
        jobs.translatesAutoresizingMaskIntoConstraints = false
        return jobs
    }()
    private let stylistCollectionView: StylistsCollectionView = {
        let stylists = StylistsCollectionView()
        stylists.translatesAutoresizingMaskIntoConstraints = false
        return stylists
    }()
    private let settingSideBar: SettingsSideBar = {
        let sideBar = SettingsSideBar()
        sideBar.translatesAutoresizingMaskIntoConstraints = false
        return sideBar
    }()
    private let profilePicturePickerView: ProfileUploadView = {
        let picker = ProfileUploadView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    let stylistSideBar: StylistDashBoardView = {
        let profile = StylistDashBoardView()
        profile.translatesAutoresizingMaskIntoConstraints = false
        return profile
    }()
    private let clientSideBar: ClientDashBoard = {
        let clientBar = ClientDashBoard()
        clientBar.translatesAutoresizingMaskIntoConstraints = false
        return clientBar
    }()
    
    private let stilistaApi = StilistaApi()
    private let imageStorage = FirebaseStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(navBar)
        getContent()
        setUpNavBar()
        setContent()
        
    }
    deinit {
        print("MainViewController has been released from memory.")
    }
    /**
     An overrided method that removes the systems keyboard when any non textfield is touched.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // We decide here what the collection view will be filled with
    private func getContent(){
        let id = userSession!.passport.user.userId
        if userGroup == "user"{
            setUpLocationManger()
            let distance =  distanceFilter * 1600
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.stilistaApi.getStylistsNearMe(mainViewController: self, long: self.long ?? "5", lat: self.lat ?? "5", distance: distance.description)
                self.stilistaApi.getClientDetails(mainViewController: self, clientID: id)
                
            }
        }
        if userGroup == "stylist"{
            
            print("We are signing in a stylista")
            stilistaApi.getAllPosts(mainViewController: self, stylistID: id)
            stilistaApi.getStylistAccountDetails(mainViewController: self, stylistID: id)
        }
    }
    private func setContent(){
        settingSideBar.userGroup = userGroup
        if userGroup == "user"{
            addStylistCollectionView()
        }
        if userGroup == "stylist" {
            stilistaApi.getStylistReviews(stylistID: userSession!.passport.user.userId, mainViewController: self)
            addJobCollectionView()
        }
    }
    
    private func setUpNavBar(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        // Adding targets to the left and right buttons
        navBar.rightButton.addTarget(self, action: #selector(toSettings), for: .touchUpInside)
        navBar.centerButton.setTitle("↻", for: .normal)
        navBar.centerButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    }
    // Need to add the sidebar after the jobcollection view or else it'll be added behind the recycler in the viewcontroller stack. *** Rename function to better describe the method
    private func addJobCollectionView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view.addSubview(self.jobCollectionView)
            self.jobCollectionView.jobs = self.jobs
            self.setUpJobsCollectionView()
            self.view.addSubview(self.settingSideBar)
            self.settingSideBar.setUpOptions()
            self.view.addSubview(self.profilePicturePickerView)
            self.setUpSideBar()
            self.setUpProfilePicturePickerView()
            self.view.addSubview(self.stylistSideBar)
            self.setUpStylistDashBoard()
            self.navBar.leftButton.addTarget(self, action: #selector(self.toStylistDashBoard), for: .touchUpInside)
            self.stylistSideBar.bottomView.mapAndPhotos.reviewGallery.ratings = self.ratings
            self.stylistSideBar.topView.ratingView.stylistValue = self.stylistDetails?.rating
            self.stylistSideBar.bottomView.buttons.addPhotoButton.addTarget(self, action: #selector(self.toEditProfileController), for: .touchUpInside)
        }
    }
    
    @objc private func toEditProfileController(){
        print("To edited controller")
        let editedProfileViewController = EditProfileViewController()
        editedProfileViewController.stylistID = userSession?.passport.user.userId
        editedProfileViewController.email = stylistDetails?.email
        editedProfileViewController.name = stylistDetails?.name
        navigationController?.pushViewController(editedProfileViewController, animated: true)
    }
    private func addStylistCollectionView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view.addSubview(self.stylistCollectionView)
            self.stylistCollectionView.stylists = self.stylists
            self.setUpStylistCollectionView()
            self.view.addSubview(self.settingSideBar)
            // Here we will implemeted the different settings for the setting sidebar
            self.settingSideBar.setUpUserOptions()
            self.settingSideBar.appointmentsButton.addTarget(self, action: #selector(self.toAppointmentVC), for: .touchUpInside)
            self.settingSideBar.reviewsButton.addTarget(self, action: #selector(self.toReviewsVC), for: .touchUpInside)
            self.view.addSubview(self.profilePicturePickerView)
            self.setUpSideBar()
            self.setUpProfilePicturePickerView()
            self.view.addSubview(self.clientSideBar)
            self.setUpClientBar()
            self.navBar.leftButton.addTarget(self, action: #selector(self.showClientBar), for: .touchUpInside)
        }
    }
    
    @objc private func toAppointmentVC(){
        // Five the right side bars an alpha of zerp, so that they dont show in transition.
        let apointmentsViewController = AppointmentsViewController()
        navigationController?.pushViewController(apointmentsViewController, animated: true)
    }
    @objc private func toReviewsVC(){
        let reviewsController = PostedReviewsViewController()
        navigationController?.pushViewController(reviewsController, animated: true)
    }
    
    
    @objc private func refresh(){
        refreshMain()
    }
     func refreshMain(){
        let newMainViewController = MainViewController()
        newMainViewController.userSession = userSession
        newMainViewController.stylistDetails =  stylistDetails
        newMainViewController.clientDetails =  clientDetails
        newMainViewController.userGroup = userGroup
        newMainViewController.jobs = jobs
        newMainViewController.stylists =  stylists
        newMainViewController.distanceFilter = distanceFilter
        navigationController?.setViewControllers([newMainViewController], animated: false)
    }
    
    private func setUpJobsCollectionView(){
        jobCollectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        jobCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        jobCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        jobCollectionView.userSession = userSession
        jobCollectionView.navigator = navigationController
    }
    private func setUpStylistCollectionView(){
        stylistCollectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        stylistCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stylistCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stylistCollectionView.userSession = userSession
    }
    
    
    private func setUpSideBar(){
        settingSideBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        settingSideBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        settingSideBar.leadingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        settingSideBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        settingSideBar.title.addTarget(self, action: #selector(hideSettings), for: .touchUpInside)
        settingSideBar.logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        settingSideBar.changeProfilePictureButton.addTarget(self, action: #selector(showProfilePicker), for: .touchUpInside)
    }
    
    private func setUpClientBar(){
        
        navBar.leftButton.addTarget(self, action: #selector(showClientBar), for: .touchUpInside)
        clientSideBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        clientSideBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        clientSideBar.trailingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        clientSideBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        // Adding targets
        clientSideBar.title.addTarget(self, action: #selector(hideClientBar), for: .touchUpInside)
        // Setting text fields
        clientSideBar.clientID = userSession?.passport.user.userId
        clientSideBar.clientInfoFields.emailTextField.text = clientDetails?.email
        clientSideBar.clientInfoFields.nameTextField.text = clientDetails?.name
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            let imageview = self.clientSideBar.profilePicture
            let userID = self.userSession?.passport.user.userId ?? ""
            self.imageStorage.downloadImageUrl(userID: userID, image: imageview)
            print("<-------------->This is my userID: \(userID)")
        }
    }
    
    @objc private func showClientBar(){
        print("To Profile")
        let cornerRadius = clientSideBar.profilePicture.frame.width/2
        clientSideBar.profilePicture.layer.cornerRadius = cornerRadius
        UIView.animate(withDuration: 0.55, animations: {
            let x = self.view.center.x * 2
            self.clientSideBar.transform = CGAffineTransform(translationX: x, y: 0)
        })
    }
    @objc private func hideClientBar(){
        print("To Main")
        
        UIView.animate(withDuration: 0.55, animations: {
            let x = self.view.center.x * 2
            print("This is my x: \(x)")
            self.clientSideBar.transform = CGAffineTransform(translationX: -x, y: 0)
        })
        updateFilter()
    }
    
    private func updateFilter(){
        // We don't want to reload the data evertime we come back to the main view controller
        if distanceFilter != clientSideBar.filterDistanceValue{
            distanceFilter = clientSideBar.filterDistanceValue
            print("This is my distance value: \(distanceFilter)")
            let distance = distanceFilter * 1600
            stilistaApi.getStylistsNearMe(mainViewController: self, long: long ?? "5", lat: lat ?? "5", distance: distance.description)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.stylistCollectionView.stylists = self.stylists
                self.stylistCollectionView.collectionView.reloadData()
            }
        }
        
    }
    private func setUpProfilePicturePickerView(){
        profilePicturePickerView.mainViewController = self
        profilePicturePickerView.registerButton.setTitle("Change Profile Picture", for: .normal)
        
        profilePicturePickerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profilePicturePickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        profilePicturePickerView.leadingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        profilePicturePickerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        // Adding targets
        profilePicturePickerView.registerButton.addTarget(self, action: #selector(upLoadProfilePicture), for: .touchUpInside)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.setProfilePicturePicker()
        }
    }
    private func setProfilePicturePicker(){
        let button = profilePicturePickerView.profilePicture
        let userID = userSession?.passport.user.userId ?? ""
        imageStorage.downloadImageUrlForButton(userID: userID, button: button)
    }
    @objc private func upLoadProfilePicture(){
        let userID = userSession?.passport.user.userId ?? "404"
        let image = profilePicturePickerView.profilePicture.imageView?.image ?? UIImage.init()
        imageStorage.uploadProfilePicture(userID: userID, image: image)
        stylistSideBar.topView.profilePicture.image = image
        clientSideBar.profilePicture.image = image
        UIView.animate(withDuration: 0.55, animations: {
            let x = self.view.center.x
            print("This is my x: \(x)")
            self.settingSideBar.transform = CGAffineTransform(translationX: x, y: 0)
        })
        UIView.animate(withDuration: 0.55, animations: {
            let x = self.view.center.x * 2
            print("This is my x: \(x)")
            self.profilePicturePickerView.transform = CGAffineTransform(translationX: x, y: 0)
        })
    }
    
    @objc private func toSettings(){
        print("To settings nla")
        UIView.animate(withDuration: 0.55, animations: {
            let x = self.view.center.x
            print("This is my x: \(x)")
            self.settingSideBar.transform = CGAffineTransform(translationX: -x, y: 0)
        })
    }
    @objc private func showProfilePicker(){
        print("To settings mdmde")
        let cornerRadius = profilePicturePickerView.profilePicture.frame.width/2
        profilePicturePickerView.profilePicture.layer.cornerRadius = cornerRadius
        profilePicturePickerView.alpha = 1
        UIView.animate(withDuration: 0.55, animations: {
            let x = self.view.center.x * 2
            print("This is my x: \(x)")
            self.profilePicturePickerView.transform = CGAffineTransform(translationX: -x, y: 0)
        })
    }
    @objc private func hideSettings(){
        print("To settings")
        UIView.animate(withDuration: 0.55, animations: {
            let x = self.view.center.x
            print("This is my x: \(x)")
            self.settingSideBar.transform = CGAffineTransform(translationX: x, y: 0)
        })
    }
    
    private func setUpStylistDashBoard(){
        stylistSideBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stylistSideBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stylistSideBar.trailingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stylistSideBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        // Adding targets
        stylistSideBar.title.addTarget(self, action: #selector(hideStylistDashBoard), for: .touchUpInside)
        print("This is my style: \(stylistSideBar.topView.frame)")
        setStylistProfile()
    }
    
    private func setStylistProfile(){
        let name = stylistDetails?.name ?? "404"
        //let email = stylistDetails?.email ?? "404"
        let longitude = stylistDetails?.location.coordinates[0]
        let latitude = stylistDetails?.location.coordinates[1]
        stylistSideBar.bottomView.mapAndPhotos.mapView.stylistName = name
        stylistSideBar.bottomView.mapAndPhotos.mapView.long = longitude
        stylistSideBar.bottomView.mapAndPhotos.mapView.lat = latitude
        
        
        
        // setting profile picture
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setStylistPicture()
            self.stylistSideBar.bottomView.mapAndPhotos.mapView.setLocation()
        }
    }
    
    private func setStylistPicture(){
        let leftSide = stylistSideBar.topView.profilePicture
        let userID = userSession?.passport.user.userId ?? ""
        imageStorage.downloadImageUrl(userID: userID, image: leftSide)
    }
    
    @objc private func toStylistDashBoard(){
        // I have to set the corner radius when the frame has a value. Since the sidebar is off screen it wont have a frame height value.
        
        let cornderRadius = (stylistSideBar.topView.frame.height/2) - 10
        stylistSideBar.topView.profilePicture.layer.cornerRadius = cornderRadius
        let centerDot = stylistSideBar.bottomView.mapAndPhotos.mapView.centerCircle
        let centDotCornerRadius = centerDot.frame.width/2
        centerDot.layer.cornerRadius = centDotCornerRadius
        print("To Profile")
        UIView.animate(withDuration: 0.55, animations: {
            let x = self.view.center.x * 2
            self.stylistSideBar.transform = CGAffineTransform(translationX: x, y: 0)
        })
    }
    @objc private func hideStylistDashBoard(){
        print("To Main")
        UIView.animate(withDuration: 0.55, animations: {
            let x = self.view.center.x * 2
            self.stylistSideBar.transform = CGAffineTransform(translationX: -x, y: 0)
        })
    }
    
    @objc private func showLocation(){
        let bottomPart = stylistSideBar.bottomView.mapAndPhotos
        print("Show location")
        UIView.animate(withDuration: 0.55, animations: {
            let y = self.stylistSideBar.bottomView.buttons.center.y * 2
            bottomPart.transform = CGAffineTransform(translationX: 0, y: y)
        })
    }
    
    
    
    @objc private func logout(){
        print("Logout")
        if userGroup == "user" {
            jobCollectionView.collectionView.delegate = nil
            jobCollectionView.collectionView.dataSource = nil
        }
        if userGroup == "stylist" {
            stylistCollectionView.collectionView.delegate = nil
            stylistCollectionView.collectionView.dataSource = nil
            stylistSideBar.bottomView.mapAndPhotos.mapView.map.delegate = nil
        }
        stilistaApi.logout(mainViewController: self)
    }
    
    
    // <-----------Getting users location---------->
    
    private func setUpLocationManger(){
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
        }else{
            print("Could not get the fucking location")
        }
    }
    
    
    
    

}

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        lat = locValue.latitude.description
        long = locValue.longitude.description
    }
    
}
