//
//  LoginViewModel.swift
//  BillableHours
//
//  Created by Olusegun Solaja on 29/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import Foundation
class LoginViewModel {
    typealias DidLogin = ((Employee) -> Void)
    typealias LoginFailed = ((String) -> Void)
    
    var username:String?
    var password:String?
    var isLoggedIn = false
    var didLogin: DidLogin?
    var loginFailed: LoginFailed?
    
    func login(){
        guard let userName =  username, let  pass = password else{
            return
        }
        if let emp = try? AppDelegate.employeeStorage.object(forKey: "employees"){
          let employee =  emp.filter { (employee) -> Bool in
                return userName == employee.username! && pass == employee.password!
            }.first
            if let _emp = employee {
                self.isLoggedIn = true
                self.didLogin?(_emp)
            }else{
                self.loginFailed?("Employee credential is incorrect")
            }
        }else{
           self.loginFailed?("No Employee record exists")
        }
        
    }
}
