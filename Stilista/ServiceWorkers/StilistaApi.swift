//
//  StilistaApi.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/15/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import Foundation
import UIKit
struct StilistaApi {
    
    private let keyChain = KeychainSwift()
    private let firebaseStorage = FirebaseStorage()
    
    /**
     A post http request to authenticate and login the user. If authentication is successful then we will set the navigationController to the jobViewController with the user's properties.
     */
   public func stylistLogin(email: String, password: String, loginViewController: LoginViewController){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/stylists/login"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["email": email,"password": password]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Failed \(error)")
                    }
                    guard let data = data else {return}
                    do{
                        let user = try JSONDecoder().decode(UserSession.self, from: data)
                        self.keyChain.set(data, forKey: "userID")
                        self.keyChain.set(user.passport.user.userGroup, forKey: "userGroup")
                        print(user)
                        let mainViewController = MainViewController()
                        mainViewController.userSession = user
                        mainViewController.userGroup = user.passport.user.userGroup
                        
                        loginViewController.navigationController?.setViewControllers([mainViewController], animated: true)
                    }catch _{
                        let alert = UIAlertController(title: "Failed to login", message: "Entered wrong username or password.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        loginViewController.present(alert, animated: true)
                    }
                    
                }
                }.resume()
        }catch let error{
            print(error)
        }
    }
    public func firstStylistLogin(email: String, password: String, registerViewController: RegisterViewController, image: UIImage){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/stylists/login"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["email": email,"password": password]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Failed \(error)")
                    }
                    guard let data = data else {return}
                    do{
                        let user = try JSONDecoder().decode(UserSession.self, from: data)
                        self.keyChain.set(data, forKey: "userID")
                        self.keyChain.set(user.passport.user.userGroup, forKey: "userGroup")
                        print(user)
                        let mainViewController = MainViewController()
                        mainViewController.userSession = user
                        mainViewController.userGroup = user.passport.user.userGroup
                        self.firebaseStorage.uploadProfilePicture(userID: user.passport.user.userId, image: image)
                        registerViewController.navigationController?.setViewControllers([mainViewController], animated: true)
                    }catch let error{
                        print(error)
                        print("Faild here for first stylist login")
                        print(String(data: data, encoding: .utf8) as Any)
                    }
                    
                }
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    func registerStylist(name: String, email: String, password: String, password2: String, long: Double, lat: Double, image: UIImage, registerViewController: RegisterViewController){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/stylists/register"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["name": name, "email": email, "password": password, "password2": password2, "long": long, "lat": lat] as [String : Any]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                guard data != nil else {return}
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    self.firstStylistLogin(email: email, password: password, registerViewController: registerViewController, image: image)
                })
                
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    func updateJobStatus(jobID: String, status: Bool){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/jobs/update/\(jobID)"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        let params = ["status": status]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                guard let data = data else {return}
                // Here is where we will save sign in status in core data
                print(String(data: data, encoding: .utf8) as Any)
                
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    
    
    func deleteJob(jobID: String){
        DispatchQueue.main.async {
            let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/jobs/delete/\(jobID)"
            guard let url = URL(string: jsonUrlString) else {return}
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "DELETE"
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                print("Successfully deleted post.")
                
                }.resume()
        }
    }
    
    
    
    func logout(mainViewController: MainViewController){
        keyChain.delete("userID")
        keyChain.delete("userGroup")
        URLSession.shared.reset {
            print("Successfully signout")
            DispatchQueue.main.async {
                mainViewController.navigationController?.setViewControllers([LoginViewController()], animated: true)
            }
        }
        
    }
    
    func signInStatus(loginViewController: LoginViewController){
        let data = keyChain.getData("userID")
        let userGroup = keyChain.get("userGroup")
        let cookies = HTTPCookieStorage.shared.cookies
        if !cookies!.isEmpty {
            // Precaution if the server sends a cookie by using the wrong authentication
            if data == nil || userGroup == nil {
                keyChain.delete("userID")
                keyChain.delete("userGroup")
                print("User is not signed in")
            }else{
                do{
                    print("User is signed in")
                    let user = try JSONDecoder().decode(UserSession.self, from: data!)
                    let mainViewController = MainViewController()
                    mainViewController.userSession = user
                    mainViewController.userGroup = userGroup
                    loginViewController.navigationController?.setViewControllers([mainViewController], animated: true)
                }catch let jsonError {
                    print("Error serializing json:",jsonError)
                    
                }
            }
            
        }else {
            print("User is not signed in")
        }
        
        
    }
    
    func createJob(name: String, userID: String, message: String, stylist: String, appointment: String){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/jobs/postJob/\(userID)"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["name":name, "message":message,"stylist":stylist,"user":userID, "appointment": appointment]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                guard let data = data else {return}
                // Here is where we will save sign in status in core data
                print(String(data: data, encoding: .utf8) as Any)
                
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    func getAllPosts(mainViewController: MainViewController, stylistID: String){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/jobs/\(stylistID)"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get json from url \(error)")
            }else{
                guard let data = data else {return}
                do{
                    let jobs = try JSONDecoder().decode([Job].self, from: data)
                    mainViewController.jobs = jobs
                }catch let jsonError {
                    self.logout(mainViewController: mainViewController)
                    print("Error serializing json:",jsonError)
                }
            }
            }.resume()
    }
    
    func getStylistAccountDetails(mainViewController: MainViewController, stylistID: String){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/stylists/\(stylistID)"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get json from url \(error)")
            }else{
                guard let data = data else {return}
                do{
                    let stylist = try JSONDecoder().decode(Stylist.self, from: data)
                    mainViewController.stylistDetails = stylist
                }catch let jsonError {
                    print("Error serializing json:",jsonError)
                }
            }
            }.resume()
    }
    
    
    
    
    // <------------- Client Api ------------------>
    
    public func clientLogin(email: String, password: String, loginViewController: LoginViewController){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/users/login"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["email": email,"password": password]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Failed \(error)")
                    }
                    guard let data = data else {return}
                    do{
                        let user = try JSONDecoder().decode(UserSession.self, from: data)
                        loginViewController.loginButton.isEnabled = false
                        loginViewController.loginButton.setTitle("Loading....", for: .normal)
                        self.keyChain.set(data, forKey: "userID")
                        self.keyChain.set(user.passport.user.userGroup, forKey: "userGroup")
                        let mainViewController = MainViewController()
                        mainViewController.userSession = user
                        mainViewController.userGroup = user.passport.user.userGroup
                        loginViewController.navigationController?.setViewControllers([mainViewController], animated: true)
                    }catch _{
                        let alert = UIAlertController(title: "Failed to login", message: "Entered wrong username or password.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        loginViewController.present(alert, animated: true)
                    }
                    
                }
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    
    private func firstClientLogin(email: String, password: String, registerViewController: RegisterViewController, image: UIImage){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/users/login"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["email": email,"password": password]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Failed \(error)")
                    }
                    guard let data = data else {return}
                    do{
                        let user = try JSONDecoder().decode(UserSession.self, from: data)
                        self.keyChain.set(data, forKey: "userID")
                        self.keyChain.set(user.passport.user.userGroup, forKey: "userGroup")
                        print(user)
                        let mainViewController = MainViewController()
                        mainViewController.userSession = user
                        mainViewController.userGroup = user.passport.user.userGroup
                        self.firebaseStorage.uploadProfilePicture(userID: user.passport.user.userId, image: image)
                        registerViewController.navigationController?.setViewControllers([mainViewController], animated: true)
                    }catch let error{
                        print(error)
                        print("Faild here for first login")
                        print(String(data: data, encoding: .utf8) as Any)
                    }
                    
                }
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    func registerClient(name: String, email: String, password: String, password2: String, registerViewController: RegisterViewController, image: UIImage){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/users/register"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["name": name, "email": email, "password": password, "password2": password2]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if error != nil {
                    print("Failed Registration")
                }
                guard data != nil else {return}
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    self.firstClientLogin(email: email, password: password, registerViewController: registerViewController, image: image)
                })
                }.resume()
        }catch let error{
            print("Failed with registration 2.... \(error)")
        }
    }
    
    
    func getStylistsNearMe(mainViewController: MainViewController, long: String, lat: String, distance: String){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/stylists/near"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["long": long, "lat": lat, "distance": distance]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                guard let data = data else {return}
                do {
                    let stylists = try JSONDecoder().decode([Stylist].self, from: data)
                    mainViewController.stylists = stylists
                    print(stylists)
                }catch let error{
                    print(error)
                    print("Faild here in grabbing nearby stylists and this is my lat and long: \(lat), \(long), \(distance)")
                    print(String(data: data, encoding: .utf8) as Any)
                    self.logout(mainViewController: mainViewController)
                }
                
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    
    func getClientDetails(mainViewController: MainViewController, clientID: String){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/users/\(clientID)"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get json from url \(error)")
            }else{
                guard let data = data else {return}
                do{
                    let client = try JSONDecoder().decode(Client.self, from: data)
                    mainViewController.clientDetails = client
                }catch let jsonError {
                    print("Error serializing json:",jsonError)
                }
            }
            }.resume()
    }
    func getClientDetailsForRate(rateModel: RatingModel, clientID: String){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/users/\(clientID)"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get json from url \(error)")
            }else{
                guard let data = data else {return}
                do{
                    let client = try JSONDecoder().decode(Client.self, from: data)
                    rateModel.clientDetails = client
                }catch let jsonError {
                    print("Error serializing json:",jsonError)
                }
            }
            }.resume()
    }
    
    func updateClient(clientID: String, name: String, email: String){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/users/update/\(clientID)"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        let params = ["name": name, "email": email]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                guard let data = data else {return}
                // Here is where we will save sign in status in core data
                print(String(data: data, encoding: .utf8) as Any)
                
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    
//    <----------------------------RATING CRUD----------------------------------------->
    
    func getStylistReviews(stylistID: String, mainViewController: MainViewController){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/ratings/reviewsFor/\(stylistID)"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get json from Rating url \(error)")
            }else{
                guard let data = data else {return}
                do{
                    let ratings = try JSONDecoder().decode([Rating].self, from: data)
                    mainViewController.ratings = ratings
                }catch let jsonError {
                    self.logout(mainViewController: mainViewController)
                    print("Error serializing json:",jsonError)
                }
            }
            }.resume()
    }
    func getStylistReviews(stylistID: String, collection: ReviewCollectionView){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/ratings/reviewsFor/\(stylistID)"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get json from Rating url \(error)")
            }else{
                guard let data = data else {return}
                do{
                    let ratings = try JSONDecoder().decode([Rating].self, from: data)
                    collection.ratings = ratings
                }catch let jsonError {
                    print("Error serializing json:",jsonError)
                }
            }
            }.resume()
    }
    
    func getStylistReviews(stylistID: String, rate: RatingModel){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/ratings/reviewsFor/\(stylistID)"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get json from Rating url \(error)")
            }else{
                guard let data = data else {return}
                do{
                    let ratings = try JSONDecoder().decode([Rating].self, from: data)
                    rate.ratings = ratings
                }catch let jsonError {
                    print("Error serializing json:",jsonError)
                }
            }
            }.resume()
    }
    
    func getAppointments(clientID: String, appointmentsViewController: AppointmentsViewController){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/jobs/clients/\(clientID)"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get json from Rating url \(error)")
            }else{
                guard let data = data else {return}
                do{
                    let appointments = try JSONDecoder().decode([Job].self, from: data)
                    appointmentsViewController.appointments = appointments
                }catch let jsonError {
                    print("Error serializing json:",jsonError)
                }
            }
            }.resume()
    }
    
    func postRating(clientID: String, name: String, stylistID: String, value: Int, review: String, controller: RateStylistViewController){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/ratings/postRatings/\(clientID)"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["name": name, "stylist": stylistID, "value": value, "review": review] as [String : Any]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                guard data != nil else {return}
                DispatchQueue.main.async {
                    controller.navigationController?.popViewController(animated: true)
                }
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    func getStylistAccountDetailsForRate(rate: RatingModel, stylistID: String){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/stylists/\(stylistID)"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get json from url \(error)")
            }else{
                guard let data = data else {return}
                do{
                    let stylist = try JSONDecoder().decode(Stylist.self, from: data)
                    rate.stylistDetails = stylist
                }catch let jsonError {
                    print("Error serializing json:",jsonError)
                }
            }
            }.resume()
    }
    
    func updateRating(stylistID: String, rating: Int){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/stylists/updateRating/\(stylistID)"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        let params = ["rating": rating]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                guard let data = data else {return}
                // Here is where we will save sign in status in core data
                print(String(data: data, encoding: .utf8) as Any)
                
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    func updateStylist(stylistID: String, name: String, email: String){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/stylists/update/\(stylistID)"
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        let params = ["name": name, "email": email]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Failed \(error)")
                }
                guard let data = data else {return}
                // Here is where we will save sign in status in core data
                print(String(data: data, encoding: .utf8) as Any)
                
                }.resume()
        }catch let error{
            print(error)
        }
    }
    
    func getClientReviews(clientID: String, reviewsViewController: PostedReviewsViewController){
        let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/ratings/\(clientID)"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to get json from Rating url \(error)")
            }else{
                guard let data = data else {return}
                do{
                    let ratings = try JSONDecoder().decode([Rating].self, from: data)
                    reviewsViewController.ratings = ratings
                }catch let jsonError {
                    print("Error serializing json:",jsonError)
                }
            }
            }.resume()
    }
    
    func deleteReview(reviewID: String){
        DispatchQueue.main.async {
                   let jsonUrlString = "https://sheltered-plateau-41301.herokuapp.com/ratings/delete/\(reviewID)"
                   guard let url = URL(string: jsonUrlString) else {return}
                   var urlRequest = URLRequest(url: url)
                   urlRequest.httpMethod = "DELETE"
                   URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                       if let error = error {
                           print("Failed \(error)")
                       }
                       print("Successfully deleted post.")
                       
                       }.resume()
               }
    }
    
}
