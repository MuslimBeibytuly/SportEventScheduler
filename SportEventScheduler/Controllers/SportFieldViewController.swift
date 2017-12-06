//
//  SportFieldViewController.swift
//  SportEventScheduler
//
//  Created by Mirzhan Gumarov on 12/3/17.
//  Copyright © 2017 Mirzhan Gumarov. All rights reserved.
//

import UIKit

class SportFieldViewController: UIViewController {
    let ownerName = UILabel()
    let ownerPhone = UILabel()
    let fieldDescription = UILabel()
    let sportTypeLabel = UILabel()
    let sportTypeImageView = UIImageView()
    let moveToScheduleButton = UIButton()
    let moveToMapButton = UIButton()
    
    var sportField: PlayingField? {
        didSet {
            self.changeTitle(sportField!.name)
            ownerName.text = sportField?.owner.name
            ownerPhone.text = sportField?.owner.phone
            fieldDescription.text = sportField?.description
            sportTypeLabel.text = sportField?.sportType.rawValue
            sportTypeImageView.image = Constants.sportTypeImages[sportField!.sportType.rawValue]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(ownerName)
        view.addSubview(ownerPhone)
        view.addSubview(fieldDescription)
        view.addSubview(sportTypeLabel)
        view.addSubview(sportTypeImageView)
        view.addSubview(moveToScheduleButton)
        view.addSubview(moveToMapButton)
        addConstraints()
    }
    
    private func changeTitle(_ title: String) {
        self.title = title
    }
    
    @objc private func moveToScheduleViewController() {
        let viewController = ScheduleViewController()
        present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
    }
    
    @objc private func moveToMapViewController() {
        let viewController = MapViewController()
        viewController.sportField = sportField!
        present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
    }
    
    private func addConstraints(){
        ownerName.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
        
        ownerPhone.snp.makeConstraints { (make) in
            make.top.equalTo(ownerName.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        fieldDescription.snp.makeConstraints { (make) in
            make.top.equalTo(ownerPhone.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        sportTypeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fieldDescription.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        sportTypeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(sportTypeLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        moveToScheduleButton.setTitle("Schedule", for: .normal)
        moveToScheduleButton.setTitleColor(.blue, for: .normal)
        moveToScheduleButton.addTarget(self, action: #selector(moveToScheduleViewController), for: .touchUpInside)
        moveToScheduleButton.snp.makeConstraints { (make) in
            make.top.equalTo(sportTypeImageView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        moveToMapButton.setTitle("Show Location", for: .normal)
        moveToMapButton.setTitleColor(.blue, for: .normal)
        moveToMapButton.addTarget(self, action: #selector(moveToMapViewController), for: .touchUpInside)
        moveToMapButton.snp.makeConstraints { (make) in
            make.top.equalTo(moveToScheduleButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
}
