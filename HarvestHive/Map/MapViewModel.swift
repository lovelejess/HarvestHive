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

    var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var shouldShowErrorAlert: Bool = false
    private var subscriptions = Set<AnyCancellable>()
    private var locationManager: LocationManager

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self.locationManager.userLocation
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("Received finished")
                case .failure(let error):
                    self?.shouldShowErrorAlert = true
                    print("JESS: location.shouldShowErrorAlert is \(self?.shouldShowErrorAlert)")
                }
            } receiveValue: { [weak self] location in
                self?.region = location.region
                print("JESS: location.showsshow is \(location.locationFailure)")
                self?.shouldShowErrorAlert = false
            }.store(in: &subscriptions)
    }
}
