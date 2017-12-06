//
//  PlayingField.swift
//  SportEventScheduler
//
//  Created by Mirzhan Gumarov on 12/3/17.
//  Copyright © 2017 Mirzhan Gumarov. All rights reserved.
//

import UIKit
import MapKit

enum SportType: String {
    case football = "football"
    case tennis = "tennis"
}

class PlayingField {
    let name: String
    let owner: Owner
    let description: String
    let sportType: SportType
    let coordinate: CLLocationCoordinate2D
    
    init(name: String, description: String, owner: Owner, sportType: SportType, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.description = description
        self.owner = owner
        self.sportType = sportType
        self.coordinate = coordinate
    }
}


