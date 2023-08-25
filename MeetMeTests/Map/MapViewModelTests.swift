//
//  MapViewModelTests.swift
//  MeetMeTests
//
//  Created by Jess Lê on 8/9/23.
//

import Combine
import XCTest
import MapKit
@testable import MeetMe

final class MapViewModelTests: XCTestCase {
    private var subscriptions = Set<AnyCancellable>()

    func test_title_returns_title() {
        let locationManager = LocationManager()
        let actual = MapViewModel(locationManager: locationManager)

        XCTAssertEqual(actual.title, "MeetX Locations")
    }

    func test_region_updatesWithNewLocation_whenLocationManagerChangesRegion() throws {
        let locationManager = LocationManager()
        let viewModel = MapViewModel(locationManager: locationManager)

        let expected = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0))
        locationManager.region = expected

        assertCoordinateRegionAreEqual(actual: try XCTUnwrap(viewModel.region), expected: expected)

    }
}

extension XCTest {
    func assertCoordinateRegionAreEqual(actual: MKCoordinateRegion, expected: MKCoordinateRegion) {
        XCTAssertEqual(actual.center.latitude, expected.center.latitude)
        XCTAssertEqual(actual.center.longitude, expected.center.longitude)
        XCTAssertEqual(actual.span.latitudeDelta, expected.span.latitudeDelta)
        XCTAssertEqual(actual.span.longitudeDelta, expected.span.longitudeDelta)
    }
}
