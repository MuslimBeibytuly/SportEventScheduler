//
//  MapViewController.swift
//  SportEventScheduler
//
//  Created by Mirzhan Gumarov on 12/5/17.
//  Copyright © 2017 Mirzhan Gumarov. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let mapView = MKMapView()
    private let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    private let almatyLocation = CLLocationCoordinate2D(latitude: 43.255378, longitude: 76.943002)
    
    var sportField: PlayingField! {
        didSet {
            putAnnotation(field: sportField)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Location"
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissPage))
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func putAnnotation(field: PlayingField){
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = field.coordinate
        annotation.title = field.name
        annotation.subtitle = field.sportType.rawValue
        mapView.addAnnotation(annotation)
        
        moveToRegion(coordinates: field.coordinate, span: span)
    }
    
    func moveToRegion(coordinates: CLLocationCoordinate2D, span: MKCoordinateSpan){
        let region = MKCoordinateRegion(center: coordinates, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc private func dismissPage() {
        self.dismiss(animated: true, completion: nil)
    }
}
