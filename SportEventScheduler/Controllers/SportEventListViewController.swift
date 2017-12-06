//
//  SportEventListViewController.swift
//  SportEventScheduler
//
//  Created by Mirzhan Gumarov on 12/3/17.
//  Copyright © 2017 Mirzhan Gumarov. All rights reserved.
//

import UIKit

class SportEventListViewController: UIViewController {
    
    let tableView = UITableView()
    let events: [PlayingField] = Constants.getMockPlayingField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sport events"
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SportFieldTableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension SportEventListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SportFieldTableViewCell
        
        cell.playingField = events[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = SportFieldViewController()
        viewController.sportField = events[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
