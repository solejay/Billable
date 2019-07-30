//
//  BillableViewModel.swift
//  BillableHours
//
//  Created by Olusegun Solaja on 29/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import Foundation
class BillableViewModel {
    var projects:[Project]?
    var employee:Employee?
    var selectedProject:Project?
    var selectedTimeCard:Timecard?
    
    var startTime:Date?
    var endTime:Date? 
    
    var didFetchProjects: (() -> Void)?
    var projectFetchFailed: ((String) -> Void)?
    func fetchProjects(){
        if let proj = try? AppDelegate.projects.object(forKey: "projects"){
            self.projects = proj
        }
    }
    

    func fetchProjectsByEmployee(){
        guard let  emp = employee else {
            return
        }
        
        if let proj = try? AppDelegate.projects.object(forKey: "projects"){
            self.projects = proj.filter({ (pro) -> Bool in
                return pro.employee?.employeeId == emp.employeeId
            })
            if self.projects!.count > 0{
                self.didFetchProjects?()
            }else{
                self.projectFetchFailed?("No project is assigned to this employee")
            }
        }else{
             self.projectFetchFailed?("No projects exists")
        }
    }
    
}
