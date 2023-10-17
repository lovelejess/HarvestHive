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
    func requestAlwaysAuthorization()
}

extension CLLocationManager: CLLocationManagerable {}

// Wrap the LocationManager Delegate into our custom protocol so that we can dependency inject and test this
// See extension implementation below
protocol LocationManagerDelegate {
    func locationManager(_ manager: CLLocationManagerable, didUpdateLocations locations: [CLLocation])
    func locationManager(_ manager: CLLocationManagerable, didFailWithError error: Error)
    func locationManager(_ manager: CLLocationManagerable, didChangeAuthorization status: CLAuthorizationStatus)
}

protocol LocationManagable {
    var region: MKCoordinateRegion { get set }
    var locationFailure: CLAuthorizationStatus? { get }
}

class LocationManager: NSObject, LocationManagable, CLLocationManagerDelegate, ObservableObject {
    @Published var region = MKCoordinateRegion()
    @Published var locationFailure: CLAuthorizationStatus?
    private let manager = CLLocationManager()
    private var locationManagerDelegate: LocationManagerDelegate?

    init(locationManager: CLLocationManagerable = CLLocationManager()) {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }

    override init() {
        super.init()
        manager.delegate = self
        locationManagerDelegate = self
    }
}

// Calls the LocationManagerDelegate methods in order to test
extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManagerDelegate?.locationManager(manager, didUpdateLocations: locations)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManagerDelegate?.locationManager(manager, didFailWithError: error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManagerDelegate?.locationManager(manager, didChangeAuthorization: status)
    }
}

// Wrap the LocationManager Delegate into our custom protocol so that we can dependency inject and test this
// This is where actual business logic happens
extension LocationManager: LocationManagerDelegate {
    func requestAlwaysAuthorization() {
        manager.requestAlwaysAuthorization()
    }

    func locationManager(_ manager: CLLocationManagerable, didFailWithError error: Error) {
        print("JESS location failure: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManagerable, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }

    func locationManager(_ manager: CLLocationManagerable, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location sharing enabled")
        case .denied, .restricted:
            print("Location sharing \(status)")
            locationFailure = status
        case .notDetermined:
            print("Location sharing not determined")
            manager.requestAlwaysAuthorization()
        @unknown default:
            print("Location sharing unknown")
            locationFailure = status
        }
    }
}
