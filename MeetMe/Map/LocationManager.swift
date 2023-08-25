//
//  LocationManager.swift
//  MeetMe
//
//  Created by Jess Lê on 8/9/23.
//

import Foundation
import MapKit

protocol LocationManagable {
    var region: MKCoordinateRegion { get set }
    
}
class LocationManager: NSObject, LocationManagable, CLLocationManagerDelegate, ObservableObject {
    @Published var region = MKCoordinateRegion()
    private let manager = CLLocationManager()

    init(locationManager: CLLocationManager = CLLocationManager()) {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    override init() {
        super.init()
        manager.delegate = self
    }
}

extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
}
