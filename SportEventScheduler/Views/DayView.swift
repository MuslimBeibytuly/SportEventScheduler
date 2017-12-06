//
//  DayView.swift
//  SportEventScheduler
//
//  Created by Mirzhan Gumarov on 12/5/17.
//  Copyright © 2017 Mirzhan Gumarov. All rights reserved.
//

import UIKit

class DayView: UIView {
    let dayLabel = UILabel()
    
    init(day: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/7, height: 20))
        
        dayLabel.text = day
        addSubview(dayLabel)
        dayLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
