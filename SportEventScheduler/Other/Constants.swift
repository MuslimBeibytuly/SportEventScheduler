//
//  Constants.swift
//  SportEventScheduler
//
//  Created by Mirzhan Gumarov on 12/3/17.
//  Copyright © 2017 Mirzhan Gumarov. All rights reserved.
//

import UIKit
import MapKit

class Constants {
    static let sportTypeImages: [String: UIImage] = [
        "football": UIImage(named: "football")!,
        "tennis": UIImage(named: "tennis")!
    ]
    
    static func getMockPlayingField() -> [PlayingField] {
        return [ 
            PlayingField(name: "Dostyk", description: "something", owner: Owner(name: "Mirzhan", phone: "87777227411"), sportType: .football, coordinate: CLLocationCoordinate2D(latitude: 43.239742, longitude: 76.920766)),
            PlayingField(name: "Anfield", description: "Somewhere", owner: Owner(name: "Mirzhan", phone: "87777227411"), sportType: .football, coordinate: CLLocationCoordinate2D(latitude: 53.430721, longitude: -2.960540)),
            PlayingField(name: "Wimbeldon", description: "London court", owner: Owner(name: "Mirzhan", phone: "87777227411"), sportType: .tennis, coordinate: CLLocationCoordinate2D(latitude: 51.435138, longitude: -0.214974)),
            PlayingField(name: "Indian Wells", description: "USA ATP", owner: Owner(name: "Mirzhan", phone: "87777227411"), sportType: .tennis, coordinate: CLLocationCoordinate2D(latitude: 33.723876, longitude: -116.305924))
        ]
    }
}
