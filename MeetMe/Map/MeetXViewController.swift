//
//  MeetXViewController.swift
//  MeetMe
//
//  Created by Jess Lê on 8/7/23.
//

import UIKit
import MapKit
import SwiftUI

class MeetXViewController: UIHostingController<MapView> {

    let locationManager: CLLocationManager = {
       let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLHeadingFilterNone
        return manager
    }()

    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addX))
        button.tintColor = .white
        button.title = "Add"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = addButton

        locationManager.startUpdatingLocation()
    }

    @objc func addX() {
        print("JESS")
    }
}
