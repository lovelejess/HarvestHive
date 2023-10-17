//
//  LocationManager.swift
//  HarvestHive
//
//  Created by Jess Lê on 8/9/23.
//

import Foundation
import MapKit

protocol CLLocationManagerable {
    var location: CLLocation? { get }
}

extension CLLocationManager: CLLocationManagerable {}

// Wrap the LocationManager Delegate into our custom protocol so that we can dependency inject and test this
// See extension implementation below
protocol LocationManagerDelegate {
    func locationManager(_ manager: CLLocationManagerable, didUpdateLocations locations: [CLLocation])
}

protocol LocationManagable {
    var region: MKCoordinateRegion { get set }
}

class LocationManager: NSObject, LocationManagable, CLLocationManagerDelegate, ObservableObject {
    @Published var region = MKCoordinateRegion()
    private let manager = CLLocationManager()
    private var locationManagerDelegate: LocationManagerDelegate?

    init(locationManager: CLLocationManagerable = CLLocationManager()) {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    override init() {
        super.init()
        manager.delegate = self
        locationManagerDelegate = self
    }
}

extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Calls the LocationManagerDelegate method in order to test
        locationManagerDelegate?.locationManager(manager, didUpdateLocations: locations)
    }
}

// Wrap the LocationManager Delegate into our custom protocol so that we can dependency inject and test this
extension LocationManager: LocationManagerDelegate {
    func locationManager(_ manager: CLLocationManagerable, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
}
