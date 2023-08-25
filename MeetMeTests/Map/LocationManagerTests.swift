//
//  LocationManagerTests.swift
//  MeetMeTests
//
//  Created by Jess Lê on 8/25/23.
//

import Combine
import MapKit
import XCTest
@testable import MeetMe

final class LocationManagerTests: XCTestCase {
    var subscription = Set<AnyCancellable>()

    func test_region_publishesUpdatedRegion_whenLocationChanges() throws {
        // ARRANGE
        let fakeLocationManager: CLLocationManagerable = FakeLocationManager()
        let locationManager = LocationManager(locationManager: fakeLocationManager)
        let expectation = self.expectation(description: "Region Publishes")
        let expected = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42, longitude: -42),
                                          span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

        var actual: MKCoordinateRegion?
        locationManager.$region
            .dropFirst()
            .sink(receiveValue: { value in
                actual = value
                expectation.fulfill()
            }).store(in: &subscription)

        // ACT
        locationManager.locationManager(fakeLocationManager, didUpdateLocations: [CLLocation(
            latitude: 42,
            longitude: -42
        )])

        // ASSERT
        waitForExpectations(timeout: 1)
        assertCoordinateRegionAreEqual(try XCTUnwrap(actual), expected)
    }
}

final class FakeLocationManager: CLLocationManagerable {
    var location: CLLocation? = CLLocation(
            latitude: 37.3317,
            longitude: -122.0325086
        )
}
