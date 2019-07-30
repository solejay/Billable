//
//  Utils.swift
//  BillableHours
//
//  Created by Olusegun Solaja on 29/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import Foundation
import Cache

func setupData(){
    //Employees
    let grade = Grade(level: .three, rate: 300)
    let employeeOne = Employee(username: "solejay", password: "password", employeeId: 1, grade: grade)
    let grade2 = Grade(level: .two, rate: 200)
    let employeeTwo = Employee(username: "dayo", password: "password", employeeId: 2, grade: grade2)
    let grade3 = Grade(level: .one, rate: 100)
    let employeeThree = Employee(username: "tayo", password: "password", employeeId: 3, grade: grade3)
    
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let startDate =  dateFormatter.date(from: "2019-07-01")
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    guard let startTime =  dateFormatter.date(from: "2019-07-01 09:00") else { return }
    guard let endTme =  dateFormatter.date(from: "2019-07-01 17:00") else { return }
    
    guard let startTime2 =  dateFormatter.date(from: "2019-07-01 09:00") else { return }
    guard let endTme2 =  dateFormatter.date(from: "2019-07-01 12:00") else { return }

    let timeCard = Timecard(activityDate: startDate, startTime: startTime, endTime: endTme)
    let timeCard2 = Timecard(activityDate: startDate, startTime: startTime2, endTime: endTme2)
    let project = Project(name: "Google", employee: employeeOne, timecards: [timeCard])
    let project2 = Project(name: "Facebook", employee: employeeOne, timecards: [timeCard2])
    let projectEmp1 = Project(name: "Google", employee: employeeTwo, timecards: [timeCard])
    let project2Emp1 = Project(name: "Facebook", employee: employeeTwo, timecards: [timeCard2])
    let projectEmp2 = Project(name: "Google", employee: employeeThree, timecards: [timeCard])
    let project2Emp2 = Project(name: "Facebook", employee: employeeThree, timecards: [timeCard2])
    
    _ =  try? AppDelegate.employeeStorage.setObject([employeeOne,employeeTwo, employeeThree], forKey: "employees")
    _ =  try? AppDelegate.projects.setObject([project,project2,projectEmp1,project2Emp1,projectEmp2,project2Emp2], forKey: "projects")
}

extension UIView{
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    func centerInViewX(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?,padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {return}
        centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    func centerInViewY(leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?,padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {return}
        centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        if let leading = leading {
            leading.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero, centerX:NSLayoutXAxisAnchor? = nil, centerY:NSLayoutYAxisAnchor? = nil) -> AnchoredConstraints  {
        translatesAutoresizingMaskIntoConstraints = false
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        return anchoredConstraints
    }
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
}
struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

enum Style{
    case  success , error
    
}
extension UIColor {
    convenience init(hex: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex:   String = hex
        
        if hex.hasPrefix("#") {
            let index   = hex.index(hex.startIndex, offsetBy: 1)
            hex         = hex.substring(from: index)
        }
        
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        } else {
            print("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

func showSnackBarWithMessage(msg: String, style:Style = .success,autoComplete:Bool = false, completion:(()-> Void)? = nil){
    if autoComplete{
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion?()
        }
    }
    let message =  msg
    let snack = SnackBar.shared
    snack.message = message
    
    switch style{
    case .success:
        snack.statusColor = UIColor(hex: "#397A7F")
    case .error:
        snack.statusColor = UIColor(hex: "#9C4A47")
    }
    
    snack.show()
}
