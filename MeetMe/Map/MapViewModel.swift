//
//  MapViewModel.swift
//  MeetMe
//
//  Created by Jess Lê on 8/9/23.
//

import Foundation
import MapKit
import Combine

class MapViewModel: ObservableObject {

    var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    private var subscriptions = Set<AnyCancellable>()
    private var locationManager: LocationManager

    var title: String {
        return "MeetX Locations"
    }

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self.locationManager.$region
            .sink(receiveValue: { [weak self] location in
                self?.region = location
            }).store(in: &subscriptions)
    }
}
