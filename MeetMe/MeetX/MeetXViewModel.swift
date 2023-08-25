//
//  MeetXViewModel.swift
//  MeetMe
//
//  Created by Jess Lê on 8/25/23.
//

import Foundation

class MeetXViewModel {
    weak var coordinatorDelegate: Coordinatable?

    var title: String {
        return "MeetX Locations"
    }

    func didPressAddX() {
        print("JESS")
        coordinatorDelegate?.navigate(to: .rootTabBar(.meetX(.add)))
    }
}
