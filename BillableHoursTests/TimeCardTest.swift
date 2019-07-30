//
//  TimeCardTest.swift
//  BillableHoursTests
//
//  Created by Olusegun Solaja on 29/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import XCTest
@testable import BillableHours
class TimeCardTest: XCTestCase {

   
    func testMinimumBillableHour() {
        //Given
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDate =  dateFormatter.date(from: "2019-07-01")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let startTime =  dateFormatter.date(from: "2019-07-01 09:00") else { return }
        guard let endTme =  dateFormatter.date(from: "2019-07-01 17:00") else { return }
        let timeCard = Timecard(activityDate: startDate, startTime: startTime, endTime: endTme)
        
        XCTAssertTrue(timeCard.isMininumbillableHour())
    }
    
    func testIsNotMinimumBillableHour() {
        //Given
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDate =  dateFormatter.date(from: "2019-07-01")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let startTime =  dateFormatter.date(from: "2019-07-01 09:00") else { return }
        guard let endTme =  dateFormatter.date(from: "2019-07-01 9:30") else { return }
        let timeCard = Timecard(activityDate: startDate, startTime: startTime, endTime: endTme)
        
        XCTAssertFalse(timeCard.isMininumbillableHour())
    }

    func testStartDateIsNotInTheFuture() {
        //Given
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDate =  dateFormatter.date(from: "2019-07-01")
        let startDate2 =  dateFormatter.date(from: "2020-07-01")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let startTime =  dateFormatter.date(from: "2019-07-01 09:00") else { return }
        guard let endTme =  dateFormatter.date(from: "2019-07-01 9:30") else { return }
        let timeCard = Timecard(activityDate: startDate, startTime: startTime, endTime: endTme)
        
        XCTAssertFalse(timeCard.isStartDateInTheFutue())
        
       
        guard let startTime2 =  dateFormatter.date(from: "2020-07-01 09:00") else { return }
        guard let endTme2 =  dateFormatter.date(from: "2020-07-01 9:30") else { return }
        let timeCard2 = Timecard(activityDate: startDate2, startTime: startTime2, endTime: endTme2)
        
         XCTAssertTrue(timeCard2.isStartDateInTheFutue())
    }
    
    func testBillableHoursMustBeInHours() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDate =  dateFormatter.date(from: "2019-07-01")
         let startDate2 =  dateFormatter.date(from: "2020-07-01")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let startTime =  dateFormatter.date(from: "2019-07-01 09:00") else { return }
        guard let endTme =  dateFormatter.date(from: "2019-07-01 10:00") else { return }
        let timeCard = Timecard(activityDate: startDate, startTime: startTime, endTime: endTme)
        
        XCTAssertTrue(timeCard.mustBeInHours())
        guard let startTime2 =  dateFormatter.date(from: "2020-07-01 09:00") else { return }
        guard let endTme2 =  dateFormatter.date(from: "2020-07-01 9:30") else { return }
        let timeCard2 = Timecard(activityDate: startDate2, startTime: startTime2, endTime: endTme2)
        
        XCTAssertFalse(timeCard2.mustBeInHours())
    }

  

}
