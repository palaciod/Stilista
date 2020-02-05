//
//  Job.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/16/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import Foundation

struct Job: Decodable{
    let name: String
    let message: String
    let _id: String
    let date: String
    let user: String
    let stylist: String
    let status: Bool
    let appointment: String
}
