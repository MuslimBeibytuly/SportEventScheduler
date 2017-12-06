//
//  ScheduleTableViewCell.swift
//  SportEventScheduler
//
//  Created by Mirzhan Gumarov on 12/5/17.
//  Copyright © 2017 Mirzhan Gumarov. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    private let leadingOffset = UIScreen.main.bounds.width / 4
    
    let categoryLine = UIView()
    let startTimeLabel = UILabel()
    let endTimeLabel = UILabel()
    
    let titleLabel = UILabel()
    let noteLabel = UILabel()
    
    var schedule: Schedule! {
        didSet {
            titleLabel.text = schedule.title
            noteLabel.text = schedule.note
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            startTimeLabel.text = dateFormatter.string(from: schedule.startTime)
            endTimeLabel.text = dateFormatter.string(from: schedule.endTime)
            categoryLine.backgroundColor = schedule.categoryColor
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(categoryLine)
        addSubview(startTimeLabel)
        addSubview(endTimeLabel)
        addSubview(titleLabel)
        addSubview(noteLabel)
        
        addSubviewConstraints()
    }
    
    private func addSubviewConstraints() {
        categoryLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(leadingOffset)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(3)
            make.height.equalTo(40)
        }
        
        startTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLine.snp.top)
            make.trailing.equalTo(categoryLine.snp.leading).offset(-5)
        }
        
        endTimeLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(categoryLine.snp.leading).offset(-5)
            make.bottom.equalTo(categoryLine.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLine.snp.top)
            make.leading.equalTo(categoryLine.snp.trailing).offset(5)
        }
        
        noteLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(categoryLine.snp.trailing).offset(5)
            make.bottom.equalTo(categoryLine.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
