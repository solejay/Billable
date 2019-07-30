//
//  TimeCardViewController.swift
//  BillableHours
//
//  Created by Olusegun Solaja on 30/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit
enum Mode{
    case create, update
}

class TimeCardViewController: UIViewController {
    var viewMode:Mode = .create
    
    lazy var startTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "Start Time"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startTimeTextField: UITextField = {
        let txt = UITextField()
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        txt.leftViewMode = .always
        txt.layer.borderWidth = 0.5
        txt.layer.cornerRadius = 4
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    lazy var endTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
         label.text = "End Time"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var endTimeTextField: UITextField = {
        let txt = UITextField()
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        txt.leftViewMode = .always
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.layer.borderWidth = 0.5
        txt.layer.cornerRadius = 4
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
     var vm:BillableViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupConstraints()
    }
    
    func configureView(){
        self.view.backgroundColor = .white
        
        view.addSubview(startTimeLabel)
        view.addSubview(startTimeTextField)
        view.addSubview(endTimeLabel)
        view.addSubview(endTimeTextField)
        view.addSubview(saveButton)
        
        dateFormatter.dateFormat = "hh:mm a"
        
        startDatePicker.datePickerMode = .time
        startDatePicker.addTarget(self, action: #selector(startTimeSelected), for: .valueChanged)
        startTimeTextField.inputView = startDatePicker

        endDatePicker.datePickerMode = .time
        endDatePicker.addTarget(self, action: #selector(endTimeSelected), for: .valueChanged)
        endTimeTextField.inputView = endDatePicker
        
        if viewMode == .update{
            saveButton.setTitle("Update", for: .normal)
            startTimeTextField.text = dateFormatter.string(from: vm.selectedTimeCard!.startTime)
            endTimeTextField.text = dateFormatter.string(from: vm.selectedTimeCard!.endTime)
            vm.startTime = vm.selectedTimeCard?.startTime
            vm.endTime = vm.selectedTimeCard?.endTime
            saveButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        }else{
            
            saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        }
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
           startTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
           startTimeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
           
           startTimeTextField.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 8),
           startTimeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
           startTimeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
           startTimeTextField.heightAnchor.constraint(equalToConstant: 45),
           
           endTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
           endTimeLabel.topAnchor.constraint(equalTo: startTimeTextField.bottomAnchor, constant: 12),
           
           endTimeTextField.topAnchor.constraint(equalTo: endTimeLabel.bottomAnchor, constant: 8),
           endTimeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
           endTimeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
           endTimeTextField.heightAnchor.constraint(equalToConstant: 45),
           
           saveButton.leadingAnchor.constraint(equalTo: endTimeTextField.leadingAnchor),
           saveButton.trailingAnchor.constraint(equalTo: endTimeTextField.trailingAnchor),
           saveButton.topAnchor.constraint(equalTo: endTimeTextField.bottomAnchor, constant: 12),
           saveButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewMode == .create{
            self.navigationItem.title = "New Time Card"
        }else{
            self.navigationItem.title = "Update Time Card"
        }
    }
    
    @objc func startTimeSelected(_  datePicker: UIDatePicker){
        vm.startTime = datePicker.date
        startTimeTextField.text = dateFormatter.string(from: datePicker.date)
    }
    @objc func endTimeSelected(_  datePicker: UIDatePicker){
        vm.endTime = datePicker.date
        endTimeTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func saveButtonTapped(){
        let timecard = Timecard(activityDate: vm.startTime, startTime: vm.startTime!, endTime: vm.endTime!)
        if (!timecard.isMininumbillableHour()){
            showSnackBarWithMessage(msg: "Billable slots must be a minimum of 1 hour",style: .error)
            return
        }
        if(!timecard.mustBeInHours()){
            showSnackBarWithMessage(msg: "Billable slots must be in hours",style: .error)
            return
        }
        
        vm.selectedProject?.saveTimeCard(timecard)
        NotificationCenter.default.post(name: NSNotification.Name("NewCardAdded"), object: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func updateButtonTapped(){
        let timecard = Timecard(activityDate: vm.startTime, startTime: vm.startTime!, endTime: vm.endTime!)
        if (!timecard.isMininumbillableHour()){
            showSnackBarWithMessage(msg: "Billable slots must be a minimum of 1 hour",style: .error)
            return
        }
        if(!timecard.mustBeInHours()){
            showSnackBarWithMessage(msg: "Billable slots must be in hours",style: .error)
            return
        }
        vm.selectedProject?.updateTimeCard(vm.selectedTimeCard!, withCard: timecard)
        NotificationCenter.default.post(name: NSNotification.Name("NewCardAdded"), object: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
