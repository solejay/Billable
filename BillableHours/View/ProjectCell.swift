//
//  ProjectCell.swift
//  BillableHours
//
//  Created by Olusegun Solaja on 29/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {
    lazy var projectTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var employeeIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var totalBillableHoursLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var totalBillableHoursTitle: UILabel = {
        let label = UILabel()
        label.text = "TOTAL HOURS"
        label.textAlignment = .right
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var ratePerHourLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ratePerHourTitle: UILabel = {
        let label = UILabel()
        label.text = "RATE PER HOUR"
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var project:Project? {
        didSet{
           self.projectTitle.text = project?.name
            self.employeeIdLabel.text = "Employee ID: \(project?.employee?.employeeId ?? -1)"
            self.totalBillableHoursLabel.text = "\(project?.totalHours  ?? 0)"
            self.ratePerHourLabel.text = "\(project?.employee?.grade?.rate  ?? 0)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(employeeIdLabel)
        addSubview(projectTitle)
        addSubview(totalBillableHoursTitle)
        addSubview(totalBillableHoursLabel)
        addSubview(ratePerHourTitle)
        addSubview(ratePerHourLabel)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            projectTitle.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            projectTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            employeeIdLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            employeeIdLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            ratePerHourTitle.topAnchor.constraint(equalTo: projectTitle.bottomAnchor, constant: 8),
            ratePerHourTitle.leadingAnchor.constraint(equalTo: projectTitle.leadingAnchor),
            
            totalBillableHoursTitle.topAnchor.constraint(equalTo: projectTitle.bottomAnchor, constant: 8),
            totalBillableHoursTitle.trailingAnchor.constraint(equalTo: employeeIdLabel.trailingAnchor),
            
            
            ratePerHourLabel.leadingAnchor.constraint(equalTo: ratePerHourTitle.leadingAnchor),
            ratePerHourLabel.topAnchor.constraint(equalTo: ratePerHourTitle.bottomAnchor,constant: 4),
            
            totalBillableHoursLabel.trailingAnchor.constraint(equalTo: totalBillableHoursTitle.trailingAnchor),
            totalBillableHoursLabel.topAnchor.constraint(equalTo: totalBillableHoursTitle.bottomAnchor,constant: 4),
        ])
    }
}
