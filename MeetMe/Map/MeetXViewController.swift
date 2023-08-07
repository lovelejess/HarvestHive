//
//  MeetXViewController.swift
//  MeetMe
//
//  Created by Jess Lê on 8/7/23.
//

import UIKit
import MapKit

class MeetXViewController: UIViewController {

    let locationManager: CLLocationManager = {
       let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLHeadingFilterNone
        return manager
    }()

    let mapView : MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        return map
    }()

    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addX))
        button.tintColor = .white
        button.title = "Add"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        navigationItem.rightBarButtonItem = addButton

        view.addSubview(mapView)
        setMapConstraints()
        mapView.delegate = self
        locationManager.startUpdatingLocation()
    }

    @objc func addX() {
        print("JESS")
    }
}

extension MeetXViewController {
    private func setMapConstraints() {
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}


extension MeetXViewController: MKMapViewDelegate {

}
