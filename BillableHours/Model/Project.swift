//
//  Project.swift
//  BillableHours
//
//  Created by Olusegun Solaja on 29/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import Foundation
struct Project:Codable {
    let name:String?
    let employee:Employee?
    var timecards:[Timecard]?
    
    var totalBillableRate:Int? {
        let totalHours = timecards?.reduce(0, { (intial, item) -> Int in
           return intial + item.hourCount!
        })
        if let emp = employee, let hours = totalHours, let rate = emp.grade?.rate{
            return hours * rate
        }else{
            return 0
        }
    }
    
    var totalHours:Int? {
        let totalHours = timecards?.reduce(0, { (intial, item) -> Int in
            return intial + item.hourCount!
        })
        if  let hours = totalHours{
            return hours
        }else{
            return 0
        }
    }
    
    func saveTimeCard( _ card:Timecard){
      var cards = timecards
      cards?.append(card)
      var projects =  try? AppDelegate.projects.object(forKey: "projects")
        for (index, obj) in projects!.enumerated() {
            if(obj.employee!.employeeId! == employee!.employeeId! && obj.name! == name!){
                projects?.remove(at: index)
            }
        }
        
       let project = Project(name: name, employee: employee, timecards: cards)
        
        projects?.append(project)
        try? AppDelegate.projects.setObject(projects!, forKey: "projects")
    }
    func updateTimeCard( _ card:Timecard, withCard c:Timecard){
        var cards = timecards
        cards  = timecards?.filter({ (_card) -> Bool in
            return _card.startTime != card.startTime
        })
        cards?.append(c)
        var projects =  try? AppDelegate.projects.object(forKey: "projects")
        for (index, obj) in projects!.enumerated() {
            if(obj.employee!.employeeId! == employee!.employeeId! && obj.name! == name!){
                projects?.remove(at: index)
            }
        }
        
        let project = Project(name: name, employee: employee, timecards: cards)
        
        projects?.append(project)
        try? AppDelegate.projects.setObject(projects!, forKey: "projects")
    }
}
