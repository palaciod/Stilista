//
//  Rating.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/30/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import Foundation

struct Rating: Decodable{
    let date: String
    let _id: String
    let client: String
    let stylist: String
    let value: Int
    let review: String
    let name: String
}
