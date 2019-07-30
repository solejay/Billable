//
//  TimeCardCell.swift
//  BillableHours
//
//  Created by Olusegun Solaja on 30/07/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class TimeCardCell: UITableViewCell {
    lazy var timeCardTitle: UILabel = {
        let label = UILabel()
        label.text = "Time Card"
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var activityDate: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var totalHours: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeCard:Timecard? {
        didSet{
          let df = DateFormatter()
          df.dateFormat = "dd MMM yyyy"
            activityDate.text = df.string(from: (timeCard?.activityDate)!)
          df.dateFormat = "HH:mm a"
            
            durationLabel.text = "\(df.string(from: (timeCard?.startTime)!)) -\(df.string(from: (timeCard?.endTime)!))"
            totalHours.text = "Hours: \(timeCard?.hourCount ?? 0)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(timeCardTitle)
        addSubview(activityDate)
        addSubview(durationLabel)
        addSubview(totalHours)
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            timeCardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            timeCardTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            activityDate.leadingAnchor.constraint(equalTo: timeCardTitle.leadingAnchor),
            activityDate.topAnchor.constraint(equalTo: timeCardTitle.bottomAnchor, constant: 8),
            
            durationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            durationLabel.topAnchor.constraint(equalTo: timeCardTitle.topAnchor),
            
            totalHours.trailingAnchor.constraint(equalTo: durationLabel.trailingAnchor),
            totalHours.topAnchor.constraint(equalTo: activityDate.topAnchor)
            
        ])
    }

}
