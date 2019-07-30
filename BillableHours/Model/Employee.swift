//
//  Employee.swift
//  BillableHours
//
//  Created by Olusegun Solaja on 29/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import Foundation

struct Employee:Codable {
    let username: String?
    let password: String?
    let employeeId: Int?
    let grade:Grade?
    
    
}

enum Level:Int,Codable {
    case one = 1, two = 2, three = 3
}

struct Grade:Codable {
    let level: Level?
    let rate: Int?
}
