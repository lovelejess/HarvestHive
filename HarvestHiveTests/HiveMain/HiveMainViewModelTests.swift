//
//  HiveMainViewModelTests.swift
//  HarvestHiveTests
//
//  Created by Jess Lê on 8/25/23.
//

import XCTest
@testable import HarvestHive

final class HiveMainViewModelTests: XCTestCase {

    func test_title_returns_title() {
        let actual = HiveMainViewModel()

        XCTAssertEqual(actual.title, "Hive Locations")
    }

}
