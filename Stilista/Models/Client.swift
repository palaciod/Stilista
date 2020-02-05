//
//  Client.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/23/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import Foundation
struct Client: Decodable {
    let date: String
    let _id: String
    let name: String
    let email: String
}
