//
//  ProjectListViewController.swift
//  BillableHours
//
//  Created by Olusegun Solaja on 29/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class ProjectListViewController: UIViewController {
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView(frame: .zero)
        return table
    }()
    var vm = BillableViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupConstraint()
        callbacks()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetch), name: NSNotification.Name("NewCardAdded"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Projects"
    }
    
    func configureView(){
        view.backgroundColor = UIColor(hex: "#DFDFDF")
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProjectCell.self, forCellReuseIdentifier: "projectCell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logOut))
        vm.fetchProjectsByEmployee()
    }
    
    func setupConstraint(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func callbacks(){
        vm.didFetchProjects = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        vm.projectFetchFailed = {  message in 
            DispatchQueue.main.async {
                showSnackBarWithMessage(msg: message, style: .error)
            }
        }
    }
    
    @objc func fetch(){
      vm.fetchProjectsByEmployee()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}

extension ProjectListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.projects?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "projectCell") as! ProjectCell
        cell.project = vm.projects?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.selectedProject =  vm.projects?[indexPath.row]
        let controller = TimeCardListViewController()
        controller.vm = vm
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @objc func logOut(){
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateInitialViewController()
        appDelegate.window?.rootViewController = controller
    }
}
