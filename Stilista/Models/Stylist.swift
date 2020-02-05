//
//  Stylist.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/18/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import Foundation

struct Stylist: Decodable{
    let location: Location
    let date: String
    let _id: String
    let name: String
    let email: String
    let rating: Int
}

struct Location: Decodable {
    let type: String
    let coordinates: [Double]
}
