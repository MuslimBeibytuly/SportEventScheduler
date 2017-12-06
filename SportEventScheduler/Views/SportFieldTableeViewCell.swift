//
//  SportFieldTableeViewCell.swift
//  SportEventScheduler
//
//  Created by Mirzhan Gumarov on 12/3/17.
//  Copyright © 2017 Mirzhan Gumarov. All rights reserved.
//

import UIKit

class SportFieldTableViewCell: UITableViewCell {
    let fieldName = UILabel()
    let fieldImageView = UIImageView()
    let ownerPhone = UILabel()
    
    var playingField: PlayingField? {
        didSet {
            fieldName.text = playingField?.name
            ownerPhone.text = playingField?.owner.phone
            fieldImageView.image = Constants.sportTypeImages[playingField!.sportType.rawValue]
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(fieldName)
        addSubview(fieldImageView)
        addSubview(ownerPhone)
        
        self.accessoryType = .disclosureIndicator
        
        addSubviews()
    }
    
    private func addSubviews(){
        fieldImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        fieldName.text = "unknown"
        fieldName.snp.makeConstraints { (make) in
            make.leading.equalTo(fieldImageView.snp.trailing).offset(10)
            make.top.equalTo(fieldImageView.snp.top)
        }
        
        ownerPhone.text = "unknown"
        ownerPhone.snp.makeConstraints { (make) in
            make.leading.equalTo(fieldImageView.snp.trailing).offset(10)
            make.bottom.equalTo(fieldImageView.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
