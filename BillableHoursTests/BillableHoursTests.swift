//
//  BillableHoursTests.swift
//  BillableHoursTests
//
//  Created by Olusegun Solaja on 29/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import XCTest
@testable import BillableHours

class BillableHoursTests: XCTestCase {
    func testFetchingProjects(){
        //given
        let vm = BillableViewModel()
        
        //when
        vm.fetchProjects()
        
        //then
        XCTAssertNotNil(vm.projects)
    }
    
    func testFetchingProjectByEmployee(){
        //given
        let grade = Grade(level: .three, rate: 300)
        let emp  = Employee(username: "solejay", password: "password", employeeId: 1, grade: grade)
        let vm = BillableViewModel()
        vm.employee = emp
        
        //when
        vm.fetchProjectsByEmployee()
        
        //then
        XCTAssertNotNil(vm.projects)
    }
    
    func testFetchingProjectByForNonExistingEmployee(){
        //given
        let grade = Grade(level: .three, rate: 300)
        let emp  = Employee(username: "femi", password: "kuit", employeeId: -1, grade: grade)
        let vm = BillableViewModel()
        vm.employee = emp
        
        //when
        vm.fetchProjectsByEmployee()
        
        //then
        XCTAssert(vm.projects!.count == 0)
    }
    
    func testTotalBillableRate(){
        //Given
        let grade = Grade(level: .three, rate: 300)
        let employeeOne = Employee(username: "solejay", password: "password", employeeId: 1, grade: grade)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDate =  dateFormatter.date(from: "2019-07-01")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let startTime =  dateFormatter.date(from: "2019-07-01 09:00") else { return }
        guard let endTme =  dateFormatter.date(from: "2019-07-01 17:00") else { return }
        let timeCard = Timecard(activityDate: startDate, startTime: startTime, endTime: endTme)
        let project = Project(name: "Google", employee: employeeOne, timecards: [timeCard])
        
        XCTAssert(project.totalBillableRate! == 2400)
        
        guard let startTime2 =  dateFormatter.date(from: "2019-07-01 09:00") else { return }
        guard let endTme2 =  dateFormatter.date(from: "2019-07-01 10:00") else { return }
        let timeCard2 = Timecard(activityDate: startDate, startTime: startTime2, endTime: endTme2)
        let project2 = Project(name: "Facebook", employee: employeeOne, timecards: [timeCard2])
        XCTAssert(project2.totalBillableRate! == 300)
    }
    
    func testTotalHoursRate(){
        let grade = Grade(level: .three, rate: 300)
        let employeeOne = Employee(username: "solejay", password: "password", employeeId: 1, grade: grade)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDate =  dateFormatter.date(from: "2019-07-01")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let startTime =  dateFormatter.date(from: "2019-07-01 09:00") else { return }
        guard let endTme =  dateFormatter.date(from: "2019-07-01 17:00") else { return }
        let timeCard = Timecard(activityDate: startDate, startTime: startTime, endTime: endTme)
        let project = Project(name: "Google", employee: employeeOne, timecards: [timeCard])
        
        XCTAssert(project.totalHours! == 8)
    }
}
