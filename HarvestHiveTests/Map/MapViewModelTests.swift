//
//  MapViewModelTests.swift
//  HarvestHiveTests
//
//  Created by Jess Lê on 8/9/23.
//

import Combine
import XCTest
import MapKit
@testable import HarvestHive

final class MapViewModelTests: XCTestCase {
    private var subscriptions = Set<AnyCancellable>()

    func test_userLocation_updatesWithRegion_whenUserLocationChangesRegionAndNotNullIsland() throws {
        let locationManager = LocationManager()

        let viewModel = MapViewModel(locationManager: locationManager)

        let expectedRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1234, longitude: 7890), span: MKCoordinateSpan(latitudeDelta: 21, longitudeDelta: 30))
        let expectedUserLocation = UserLocation(region: expectedRegion, locationFailure: nil)
        locationManager.userLocation = expectedUserLocation

        assertCoordinateRegionAreEqual(try XCTUnwrap(viewModel.region), expectedRegion)
    }

    func test_userLocation_setsShouldShowErrorAlert_toTrue_whenUserLocationChangesRegionIsNullIslandAndLocationFailureIsNotNil() throws {
        let locationManager = LocationManager()

        let viewModel = MapViewModel(locationManager: locationManager)

        let expectedRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0))
        let expectedUserLocation = UserLocation(region: expectedRegion, locationFailure: .failure)
        locationManager.userLocation = expectedUserLocation

        assertCoordinateRegionAreEqual(try XCTUnwrap(viewModel.region), expectedRegion)
        XCTAssertTrue(viewModel.shouldShowErrorAlert)
    }
}

extension XCTest {
    func assertCoordinateRegionAreEqual(_ actual: MKCoordinateRegion, _ expected: MKCoordinateRegion) {
        XCTAssertEqual(actual.center.latitude, expected.center.latitude)
        XCTAssertEqual(actual.center.longitude, expected.center.longitude)
        XCTAssertEqual(actual.span.latitudeDelta, expected.span.latitudeDelta)
        XCTAssertEqual(actual.span.longitudeDelta, expected.span.longitudeDelta)
    }
}
