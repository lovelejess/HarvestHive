//
//  LocationManagerTests.swift
//  HarvestHiveTests
//
//  Created by Jess Lê on 8/25/23.
//

import Combine
import MapKit
import XCTest
@testable import HarvestHive

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

    // MARK: didChangeAuthorization
    func test_didChangeAuthorization_doesNotSetLocationFailure_whenAuthorizationStatus_authorizedAlways() throws {
        // ARRANGE
        let fakeLocationManager: CLLocationManagerable = FakeLocationManager()
        let locationManager = LocationManager(locationManager: fakeLocationManager)

        // ACT
        locationManager.locationManager(fakeLocationManager, didChangeAuthorization: .authorizedAlways)

        // ASSERT
        XCTAssertFalse(try XCTUnwrap(fakeLocationManager as? FakeLocationManager).didRequestAlwaysAuthorization)
        XCTAssertNil(locationManager.locationFailure)
    }

    func test_didChangeAuthorization_doesNotSetLocationFailure_whenAuthorizationStatus_authorizedWhenInUse() throws {
        // ARRANGE
        let fakeLocationManager: CLLocationManagerable = FakeLocationManager()
        let locationManager = LocationManager(locationManager: fakeLocationManager)

        // ACT
        locationManager.locationManager(fakeLocationManager, didChangeAuthorization: .authorizedWhenInUse)

        // ASSERT
        XCTAssertFalse(try XCTUnwrap(fakeLocationManager as? FakeLocationManager).didRequestAlwaysAuthorization)
        XCTAssertNil(locationManager.locationFailure)
    }

    func test_didChangeAuthorization_doesNotSetLocationFailure_whenAuthorizationStatus_notDetermined() throws {
        // ARRANGE
        let fakeLocationManager: CLLocationManagerable = FakeLocationManager()
        let locationManager = LocationManager(locationManager: fakeLocationManager)

        // ACT
        locationManager.locationManager(fakeLocationManager, didChangeAuthorization: .notDetermined)

        // ASSERT
        XCTAssertNil(locationManager.locationFailure)
    }

    func test_didChangeAuthorization_requestsAlwaysAuthorization_whenAuthorizationStatus_notDetermined() throws {
        // ARRANGE
        let fakeLocationManager: CLLocationManagerable = FakeLocationManager()
        let locationManager = LocationManager(locationManager: fakeLocationManager)

        // ACT
        locationManager.locationManager(fakeLocationManager, didChangeAuthorization: .notDetermined)

        // ASSERT
        XCTAssertTrue(try XCTUnwrap(fakeLocationManager as? FakeLocationManager).didRequestAlwaysAuthorization)
    }

    func test_didChangeAuthorization_setsLocationFailure_whenAuthorizationStatusIs_denied() throws {
        // ARRANGE
        let fakeLocationManager: CLLocationManagerable = FakeLocationManager()
        let locationManager = LocationManager(locationManager: fakeLocationManager)

        // ACT
        locationManager.locationManager(fakeLocationManager, didChangeAuthorization: .denied)

        // ASSERT
        XCTAssertFalse(try XCTUnwrap(fakeLocationManager as? FakeLocationManager).didRequestAlwaysAuthorization)
        XCTAssertEqual(locationManager.locationFailure, .denied)
    }

    func test_didChangeAuthorization_setsLocationFailure_whenAuthorizationStatusIs_restricted() throws {
        // ARRANGE
        let fakeLocationManager: CLLocationManagerable = FakeLocationManager()
        let locationManager = LocationManager(locationManager: fakeLocationManager)

        // ACT
        locationManager.locationManager(fakeLocationManager, didChangeAuthorization: .restricted)

        // ASSERT
        XCTAssertFalse(try XCTUnwrap(fakeLocationManager as? FakeLocationManager).didRequestAlwaysAuthorization)
        XCTAssertEqual(locationManager.locationFailure, .restricted)
    }
}

final class FakeLocationManager: CLLocationManagerable {
    var didRequestAlwaysAuthorization = false

    func requestAlwaysAuthorization() {
        didRequestAlwaysAuthorization = true
    }

    var location: CLLocation? = CLLocation(
            latitude: 37.3317,
            longitude: -122.0325086
        )
}
