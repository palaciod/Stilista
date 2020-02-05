//
//  UserSession.swift
//  VidJot
//
//  Created by Daniel Palacio on 1/11/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import Foundation

struct UserSession: Decodable {
    let cookie: CookieSession
    let passport: passportSession
}

struct CookieSession: Decodable {
    let path: String
    let originalMaxAge: Int
    let expires: String
    let httpOnly: Bool
}

struct passportSession: Decodable {
    let user: PassportDetails
}
struct PassportDetails: Decodable {
    let userId: String
    let userGroup: String
}

