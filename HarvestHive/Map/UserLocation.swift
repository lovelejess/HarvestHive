//
//  UserLocation.swift
//  HarvestHive
//
//  Created by Jess Lê on 10/18/23.
//

import Foundation
import MapKit

struct UserLocation: Equatable {
    var region: MKCoordinateRegion
    var locationFailure: LocationError?

    init(region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 10.762622, longitude: 106.660172), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), locationFailure: LocationError? = nil) {
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
