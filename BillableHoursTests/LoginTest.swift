//
//  LoginTest.swift
//  BillableHoursTests
//
//  Created by Olusegun Solaja on 29/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import XCTest
@testable import BillableHours
class LoginTest: XCTestCase {

    
    func testLoginWithValidCredentials() {
        //given
        let vm = LoginViewModel()
        vm.username = "solejay"
        vm.password = "password"
        
        //when
        vm.login()
        
        // then
        XCTAssertTrue(vm.isLoggedIn)
    }
    
    func testLoginWithInvalidCredentials() {
        //given
        let vm = LoginViewModel()
        vm.username = "solejay2"
        vm.password = "password2"
        
        //when
        vm.login()
        
        // then
        XCTAssertFalse(vm.isLoggedIn)
    }
    func testLoginWithJustUsernameCredentialsFails() {
        //given
        let vm = LoginViewModel()
        vm.username = "solejay"
        //when
        vm.login()
        
        // then
        XCTAssertFalse(vm.isLoggedIn)
    }
    
    func testLoginWithWrongPasswordFails() {
        //given
        let vm = LoginViewModel()
        vm.username = "solejay"
        vm.password = "t1"
        //when
        vm.login()
        
        // then
        XCTAssertFalse(vm.isLoggedIn)
    }
    
    func testLoginWithEmptyCredentialsFails() {
        //given
        let vm = LoginViewModel()
        
        //when
        vm.login()
        
        // then
        XCTAssertFalse(vm.isLoggedIn)
    }


}
