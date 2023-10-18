//
//  LocationManager.swift
//  HarvestHive
//
//  Created by Jess Lê on 8/9/23.
//

import Combine
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
    var userLocation: CurrentValueSubject<UserLocation, LocationError> { get }
}

class LocationManager: NSObject, LocationManagable, CLLocationManagerDelegate, ObservableObject {
    var userLocation = CurrentValueSubject<UserLocation, LocationError>(UserLocation())
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
            userLocation.value.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }

    func locationManager(_ manager: CLLocationManagerable, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location sharing enabled")
            userLocation.send(completion: .finished)
        case .denied, .restricted:
            print("Location sharing \(status)")
            userLocation.send(completion: .failure(LocationError.denied))
        case .notDetermined:
            print("Location sharing not determined")
            manager.requestAlwaysAuthorization()
            userLocation.send(completion: .finished)
        @unknown default:
            print("Location sharing unknown")
            userLocation.send(completion: .failure(LocationError.unknown))
        }
    }
}

class UserLocation: Equatable {
    var region = MKCoordinateRegion()
    var locationFailure: LocationError?

    init(region: MKCoordinateRegion, locationFailure: LocationError?) {
        self.region = region
        self.locationFailure = locationFailure
    }

    static func == (lhs: UserLocation, rhs: UserLocation) -> Bool {
        return lhs.region.center.latitude == rhs.region.center.latitude &&
        lhs.region.center.longitude == rhs.region.center.longitude &&
        lhs.region.span.longitudeDelta == rhs.region.span.longitudeDelta &&
        lhs.region.span.latitudeDelta == rhs.region.span.latitudeDelta &&
        lhs.locationFailure == rhs.locationFailure
    }
}
