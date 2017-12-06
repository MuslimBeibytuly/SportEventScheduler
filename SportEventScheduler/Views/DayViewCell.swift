//
//  DayViewCell.swift
//  SportEventScheduler
//
//  Created by Mirzhan Gumarov on 12/5/17.
//  Copyright © 2017 Mirzhan Gumarov. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DayViewCell: JTAppleCell {
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    let eventView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        
        return label
    }()
    
    let selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lineView)
        addSubview(dayLabel)
        addSubview(eventView)
        addSubview(selectedView)
        
        addSubviewConstrainst()
    }
    
    private func addSubviewConstrainst(){
        lineView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        selectedView.clipsToBounds = true
        selectedView.layer.cornerRadius = 15
        selectedView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.width.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
        
        dayLabel.snp.makeConstraints { (make) in
            make.center.equalTo(selectedView)
        }
        
        eventView.clipsToBounds = true
        eventView.layer.cornerRadius = 3
        eventView.snp.makeConstraints { (make) in
            make.top.equalTo(selectedView.snp.bottom).offset(3)
            make.height.width.equalTo(6)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
