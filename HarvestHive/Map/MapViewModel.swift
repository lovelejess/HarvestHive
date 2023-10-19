//
//  MapViewModel.swift
//  HarvestHive
//
//  Created by Jess Lê on 8/9/23.
//

import Foundation
import MapKit
import Combine

class MapViewModel: ObservableObject {
    static let initialRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 10.762622, longitude: 106.660172), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var region: MKCoordinateRegion = initialRegion
    var shouldShowErrorAlert = false
    private var subscriptions = Set<AnyCancellable>()
    private var locationManager: LocationManager

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        subscribeToLocationChanges()
        locationManager.fetchLocation()
    }

    private func subscribeToLocationChanges() {
        self.locationManager.$userLocation
            .sink(receiveValue: { [weak self] location in
                guard let self = self else { return }
                if self.isNullIsland(region: location.region) && location.locationFailure != nil {
                    print("JESS: is Null Island")
                    self.shouldShowErrorAlert = true
                    self.region = location.region
                } else {
                    print("JESS: Updating region")
                    self.shouldShowErrorAlert = false
                    self.region = location.region
                }
            }).store(in: &subscriptions)
    }

    private func isNullIsland(region: MKCoordinateRegion) -> Bool {
        let isNullIsland = region.center.latitude == CLLocationDegrees(0) &&
        region.center.longitude == CLLocationDegrees(0) &&
        region.span.latitudeDelta == CLLocationDegrees(0.5) &&
        region.span.longitudeDelta == CLLocationDegrees(0.5)
        return isNullIsland
    }
}
