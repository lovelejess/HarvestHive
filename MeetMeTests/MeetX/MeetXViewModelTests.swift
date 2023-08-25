//
//  MeetXViewModelTests.swift
//  MeetMeTests
//
//  Created by Jess Lê on 8/25/23.
//

import XCTest
@testable import MeetMe

final class MeetXViewModelTests: XCTestCase {

    func test_title_returns_title() {
        let actual = MeetXViewModel()

        XCTAssertEqual(actual.title, "MeetX Locations")
    }

}
