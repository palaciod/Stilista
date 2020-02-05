//
//  RatingModel.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/30/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import Foundation

class RatingModel{
    private let stilistaApi = StilistaApi()
    var clientDetails: Client?
    private let keyChain = KeychainSwift()
    var clientID: String?
    var stylistID: String?
    var stylistDetails: Stylist?
    var ratings: [Rating]?
    init() {
        clientID = getClientID()
        getClientDetails()
    }
    func getClientID() -> String{
        let data = keyChain.getData("userID")
        do{
            let user = try JSONDecoder().decode(UserSession.self, from: data!)
            return user.passport.user.userId
        }catch _{
            return "404"
        }
    }
    func getClientDetails(){
        stilistaApi.getClientDetailsForRate(rateModel: self, clientID: clientID!)
    }
    func getStylistDetails(){
        stilistaApi.getStylistAccountDetailsForRate(rate: self, stylistID: stylistID!)
    }
    func getStylistReviews(){
        stilistaApi.getStylistReviews(stylistID: stylistID!, rate: self)
    }
    func addAllRatings() -> Double{
        var totalVal = 0.0
        for rating in ratings! {
            totalVal = totalVal + Double(rating.value)
        }
        return totalVal
    }
}
