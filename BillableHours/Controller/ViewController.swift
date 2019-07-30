//
//  ViewController.swift
//  BillableHours
//
//  Created by Olusegun Solaja on 29/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    var vm = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        callbacks()
    }
    
    func configureView(){
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.cornerRadius = 4
        
        usernameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        usernameTextField.leftViewMode = .always
        usernameTextField.layer.cornerRadius = 4
        
        loginButton.layer.cornerRadius = 4
        loginButton.addTarget(self, action: #selector(doLoginAction), for: .touchUpInside)
    }
    
    func callbacks(){
        vm.didLogin = {[weak self] employee in
             DispatchQueue.main.async {
              //  showSnackBarWithMessage(msg: "Log in successful", style: .success)
                self?.showHomeScreen(for: employee)
            }
        }
        
        vm.loginFailed = { message in
            DispatchQueue.main.async {
                showSnackBarWithMessage(msg: message, style: .error)
            }
        }
    }

}

extension ViewController{
    @objc func doLoginAction(){
        guard let username = usernameTextField.text, username != "", let password = passwordTextField.text, password != "" else {
                showSnackBarWithMessage(msg: "Please ensure you have entered the correct username and password", style: .error)
                return
            }        
        vm.username = username
        vm.password = password
        vm.login()
    }
    
    func showHomeScreen(for employee:Employee){
        let controller = ProjectListViewController()
        controller.vm.employee = employee
        let nav = UINavigationController(rootViewController: controller)
        self.present(nav, animated: true)
    }
}

