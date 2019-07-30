//
//  TimeCardListViewController.swift
//  BillableHours
//
//  Created by Olusegun Solaja on 30/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class TimeCardListViewController: UIViewController {
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView(frame: .zero)
        return table
    }()
    var vm:BillableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupConstraints()
       
    }
    
    func configureView(){
        view.addSubview(tableView)
        view.backgroundColor = UIColor(hex: "#DFDFDF")
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TimeCardCell.self, forCellReuseIdentifier: "timecard")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createTimeCard))
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = vm.selectedProject?.name
    }
    
    

}

extension TimeCardListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return vm.selectedProject?.timecards?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "timecard") as! TimeCardCell
        cell.timeCard = vm.selectedProject?.timecards?[indexPath.row]
       cell.selectionStyle = .none
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.selectedTimeCard = vm.selectedProject?.timecards?[indexPath.row]
        let controller = TimeCardViewController()
        controller.viewMode = .update
        controller.vm = vm
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteRequest = UIContextualAction(style: .normal, title: "Delete") { (action, view, complete) in
           self.vm.selectedProject?.timecards?.remove(at: indexPath.row)
            
            var projects =  try? AppDelegate.projects.object(forKey: "projects")
            for (index, obj) in projects!.enumerated() {
                if(obj.employee!.employeeId! == self.vm.selectedProject!.employee!.employeeId! && obj.name! == self.vm.selectedProject!.name!){
                    projects?.remove(at: index)
                }
            }
            
            projects?.append(self.vm.selectedProject!)
            try? AppDelegate.projects.setObject(projects!, forKey: "projects")
            NotificationCenter.default.post(name: NSNotification.Name("NewCardAdded"), object: nil)
            self.tableView.reloadData()
        }
        deleteRequest.backgroundColor = UIColor(hex: "#FF4A4A")
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteRequest])
        return swipeAction
    }
    
    @objc func createTimeCard(){
        let controller = TimeCardViewController()
        controller.vm = vm
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
