//
//  HiveMainViewModel.swift
//  HarvestHive
//
//  Created by Jess Lê on 8/25/23.
//

import Foundation

class HiveMainViewModel {
    weak var coordinatorDelegate: Coordinatable?

    var title: String {
        return "Hive Locations"
    }

    func didPressAddX() {
        print("JESS")
        coordinatorDelegate?.navigate(to: .rootTabBar(.hive(.add)))
    }
}
