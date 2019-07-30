//
//  TimeCard.swift
//  BillableHours
//
//  Created by Olusegun Solaja on 29/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import Foundation

struct Timecard:Codable {
    let activityDate:Date?
    let startTime:Date
    let endTime:Date
    var hourCount:Int? {
        return Calendar.current.dateComponents([.hour], from: startTime, to: endTime).hour
    }
    
    func isMininumbillableHour() -> Bool{
        let cal = Calendar.current.dateComponents([.hour], from: startTime, to: endTime)
        if let hour = cal.hour{
            return hour >= 1
        }else{
            return false
        }
    }
    
    func isStartDateInTheFutue() -> Bool{
        if let dt = activityDate{
            return  dt > Date()
        }else{
            return false
        }
    }
    
    func mustBeInHours() -> Bool{
         let cal = Calendar.current.dateComponents([.hour, .minute], from: startTime, to: endTime)
         if let hasMinutes = cal.minute, hasMinutes > 0{
           return false
         }else{
            return true
        }
    }
}
